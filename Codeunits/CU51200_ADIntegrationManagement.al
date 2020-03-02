codeunit 51200 "AD Integration Management"
{
    // Input variables from PowerShell Script
    // 1 = PowerShellUserSID
    // 3 = PowerShellSamAccountName

    trigger OnRun()
    begin
        SimulateCallFromPowerShellScript('INT\EK-JONTHE');
    end;

    var
        PowerShellUserSID: Text;
        PowerShellSamAccountName: Text;
        UserNotFoundErr: Label 'User with Windows Security ID no. %1 not found';
        HBRFunction: Codeunit HBRFunctions;

    procedure PowerShellOnBeforeRun()
    begin
    end;

    procedure PowerShellOnRun(PowerShellParameter: Text)
    var
        User: Record User;
    begin
        GetParameterValues(PowerShellParameter);

        IF CheckUserFromADscript(User) THEN BEGIN
            IF User.State = User.State::Enabled THEN BEGIN
                UpdateSalesPerson(User);
                UpdateUserSetup(User);
                UpdateContiniaUser(User);
            END;

            IF User.State = User.State::Disabled THEN
                DeleteContiniaUser(User);
        END;
    end;

    procedure PowerShellOnAfterRun()
    var
    begin
    end;

    local procedure UpdateSalesPerson(User: Record "User")
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        SalespersonCode: Code[20];
    begin
        SalespersonPurchaser.RESET;
        SalespersonCode := HBRFunction.GetUsernameFromDomainUserName(User."User Name");

        IF SalespersonCode <> '' THEN BEGIN
            IF NOT SalespersonPurchaser.GET(SalespersonCode) THEN BEGIN
                SalespersonPurchaser.INIT;
                SalespersonPurchaser.VALIDATE(Code, SalespersonCode);
                SalespersonPurchaser.INSERT(TRUE);
            END;

            SalespersonPurchaser.Name := User."Full Name";
            IF User."Contact Email" <> '' THEN
                SalespersonPurchaser."E-Mail" := User."Contact Email";
            SalespersonPurchaser.MODIFY(TRUE);
        END;
    end;

    local procedure UpdateUserSetup(User: Record "User")
    var
        UserSetup: Record "User Setup";
    begin
        IF NOT UserSetup.GET(User."User Name") THEN BEGIN
            UserSetup.INIT;
            UserSetup.VALIDATE("User ID", User."User Name");
            UserSetup.INSERT(TRUE);
        END;

        IF UserSetup."Salespers./Purch. Code" = '' THEN
            UserSetup."Salespers./Purch. Code" := HBRFunction.GetUsernameFromDomainUserName(User."User Name");

        IF User."Contact Email" <> '' THEN
            UserSetup.VALIDATE("E-Mail", User."Contact Email");

        UserSetup.MODIFY(TRUE);
    end;

    local procedure UpdateContiniaUser(User: Record "User")
    var
        ContiniaUserSetup: Record "CDC Continia User Setup";
        ContiniaUser: Record "CDC Continia User";
    begin
        IF User."Contact Email" <> '' THEN BEGIN
            IF NOT ContiniaUser.GET(User."User Name") THEN BEGIN
                CLEAR(ContiniaUser);
                ContiniaUser.VALIDATE("User ID", User."User Name");
                ContiniaUser.INSERT(TRUE);
            END ELSE BEGIN
                ContiniaUser.VALIDATE(Name, User."Full Name");
                ContiniaUser.VALIDATE("E-Mail", User."Contact Email");
                ContiniaUser.VALIDATE("NAV Login Type", ContiniaUser."NAV Login Type"::Windows);
                ContiniaUser."Send Welcome E-mail" := FALSE;
                ContiniaUser."Send Welcome E-mail (EM)" := FALSE;
                ContiniaUser.MODIFY(TRUE);
            END;

            IF NOT ContiniaUserSetup.GET(User."User Name") THEN BEGIN
                ContiniaUserSetup.INIT;
                ContiniaUserSetup.Validate("Continia User ID", User."User Name");
                ContiniaUserSetup."Can Edit Posting Lines" := True;
                ContiniaUserSetup.INSERT(TRUE);
            END;

            IF User.State = User.State::Disabled THEN BEGIN
                ContiniaUserSetup."Approval Client" := ContiniaUserSetup."Approval Client"::" ";
            END ELSE BEGIN
                ContiniaUserSetup."Approval Client" := ContiniaUserSetup."Approval Client"::"Web Client";
            END;
            ContiniaUserSetup.MODIFY;

        END;
    end;

    local procedure DeleteContiniaUser(User: Record "User")
    var
        ContiniaUserSetup: Record "CDC Continia User Setup";
    begin
        IF ContiniaUserSetup.GET(User."User Name") THEN BEGIN
            ContiniaUserSetup.DELETE(TRUE);
        END;
    end;

    local procedure GetParameterValues(PowerShellParameterString: Text)
    var
    begin
        PowerShellUserSID := '';
        PowerShellSamAccountName := '';
        PowerShellUserSID := SELECTSTR(1, PowerShellParameterString);
        PowerShellSamAccountName := UPPERCASE(SELECTSTR(2, PowerShellParameterString));

    end;

    local procedure CheckUserFromADscript(var User: Record "User") OK: Boolean
    var
    begin
        IF NOT TryGetUser(User) THEN EXIT(FALSE);
        IF IgnoreUser(User) THEN EXIT(FALSE);
        EXIT(TRUE);
    end;

    [TryFunction]
    local procedure TryGetUser(var User: Record "User")
    begin
        User.RESET;
        User.SETCURRENTKEY("Windows Security ID");
        User.SETRANGE("Windows Security ID", PowerShellUserSID);
        IF NOT User.FINDFIRST THEN
            ERROR(UserNotFoundErr, PowerShellUserSID);
    end;

    local procedure IgnoreUser(UserToCheck: Record "User"): Boolean
    begin
        WITH UserToCheck DO BEGIN
            IF "License Type" <> "License Type"::"Full User" THEN EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    //Procedures for testing --v--

    local procedure SimulateCallFromPowerShellScript(InpUserName: Code[50])
    var
        UserSimulate: Record "User";
        ProgressInfo: Dialog;
    begin
        ProgressInfo.OPEN('Updating user #1#######################');
        UserSimulate.RESET;
        PowerShellOnBeforeRun;
        IF InpUserName <> '' THEN
            UserSimulate.SETRANGE("User Name", InpUserName);
        IF UserSimulate.FINDSET THEN
            REPEAT
                ProgressInfo.UPDATE(1, UserSimulate."User Name");
                IF NOT IgnoreUser(UserSimulate) THEN
                    PowerShellOnRun(SimulateParameterValue(UserSimulate));
            UNTIL UserSimulate.NEXT = 0;
        PowerShellOnAfterRun;
        ProgressInfo.CLOSE;
    end;

    local procedure SimulateParameterValue(UserSimulate: Record "User") Param: Text
    var
        ResourceGroup: Record "Resource Group";
        SamAccountName: Text;
        EnabledValue: Text;
        Level: Text;
    begin
        SamAccountName := UserSimulate."User Name";

        IF UserSimulate.State = UserSimulate.State::Enabled THEN
            EnabledValue := 'TRUE'
        ELSE
            EnabledValue := 'FALSE';

        Param := UserSimulate."Windows Security ID" + ',' +
                     SamAccountName + ',' +
                     EnabledValue;
    end;
}