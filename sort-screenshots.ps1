<# 
SCREENSHOT SORTER by Realmlist
Sorts files by year, then by month, then by day (number).
Works with any common image files in any folder, just adjust $screenshotsFolder & $targetPath 
#>

$screenshotsFolder = "C:\Users\Realmlist\Pictures\VRChat"
# Target Folder where files should be moved to. The script will automatically create a folder for the year and month.
$targetPath = 'C:\Users\Realmlist\Pictures\VRChat'

# Get the files which should be moved, without folders
$files = Get-ChildItem $screenshotsFolder -Recurse -Include *.png, *.jpg, *.jpeg, *.bmp, *.gif | Where-Object {!$_.PsIsContainer}
 
foreach ($file in $files){

    # Get year and Month of the file
    # I used LastWriteTime since this are synced files and the creation day will be the date when it was synced
    $year = $file.LastWriteTime.Year.ToString()
    $month = $file.LastWriteTime.Month.ToString()
    $day = $file.LastWriteTime.Day.ToString()
    
    # Set Directory Path
    $Directory = $targetPath + "\" + $year + "\" + $month + "\" + $day

    # Create directory if it doesn't exsist
    if (!(Test-Path $Directory)){
        New-Item $directory -type directory
    }
    
    # Move File to new location
    $file | Move-Item -Destination $Directory
}
