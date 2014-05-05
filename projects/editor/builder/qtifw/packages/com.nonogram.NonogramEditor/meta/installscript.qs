
function Component()
{
    var programFiles = installer.environmentVariable("ProgramFiles");
    if (programFiles !== "")
        installer.setValue("TargetDir", programFiles + "/NonogramEditor")
}

Component.prototype.createOperations = function()
{
    component.createOperations();
    component.addOperation("CreateShortcut", "@TargetDir@/NonogramEditor.exe", "@DesktopDir@/Nonogram Editor.lnk",
                           "workingDirectory=@TargetDir@", "@TargetDir@/NonogramEditor.exe",
                           "iconId=1");
}
