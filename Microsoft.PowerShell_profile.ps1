# custom classes
Class AcademicSubjects: System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        $AcademicPaths = "C:/Users/$ENV:USERNAME/Desktop/rpi/"
        $SubjectNames = ForEach ($AcademicPath in $AcademicPaths) {
            If (Test-Path $AcademicPath) {
                (Get-ChildItem $AcademicPath).BaseName
            }
        }
        return [string[]] $SubjectNames
    }
}

# custom functions
function Exit-CurrentDir {
    # cd to the parent directory
    Set-Location -Path ".."
}
function Enter-Academic {
    # cd to class folders under the academic folder
    # https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_argument_completion?view=powershell-7.2
    [CmdletBinding()]
    param(
        [ValidateSet([AcademicSubjects])]
        [ArgumentCompletions([AcademicSubjects])]
        [string]
        $subject
    )
    Set-Location -Path "C:\Users\$ENV:USERNAME\Desktop\rpi\$subject"
}

# custom aliases
New-Alias -Name "back" Exit-CurrentDir
New-Alias -Name "study" Enter-Academic