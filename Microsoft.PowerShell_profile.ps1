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
function Get-GitStatus {
    # git status
    git status
}
function Add-GitCommit {
    # git commit
    param(
        [string]
        $message
    )
    git commit -m "$message"
}
function Add-GitStaging {
    # git add
    param($files)
    git add $files
    git status
}
function Enter-Projects {
    # cd to project folder
    Set-Location -Path "C:/Users/$ENV:USERNAME/Desktop/projects/"
}
function Enter-PowershellProfile {
    # cd to location of powershell profile
    Set-Location -Path "C:/Users/$ENV:USERNAME/Documents/PowerShell"
}
function Exit-CurrentDir {
    # cd to the parent directory
    Set-Location -Path ".."
}
function Connect-RasbperryPi {
    # ssh to my rasberry pi
    ssh pi@192.168.68.74
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
    Set-Location -Path "C:/Users/$ENV:USERNAME/Desktop/rpi/$subject" &&
    Get-ChildItem
}

# custom aliases
New-Alias -Name "back" Exit-CurrentDir
New-Alias -Name "study" Enter-Academic
New-Alias -Name "projects" Enter-Projects
New-Alias -Name "pie" Connect-RasbperryPi
New-Alias -Name "gadd" Add-GitStaging
New-Alias -Name "gcommit" Add-GitCommit
New-Alias -Name "gstatus" Get-GitStatus