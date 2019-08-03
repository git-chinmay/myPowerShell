<#  Script to autocopy from My Google drive to One Drive for File Synch
    Author :- Chinmay
    Version :- V1.0
    Date Modified :- 3rd July 2019
 #>



$source_location = "F:\"
$destination_location = "C:\Users\Chinmay\OneDrive\MY_DATA_DND"
#$logfile_location = "C:\Users\Chinmay\OneDrive\LogFile_DND\Log_" + (get-date).ToString("dd-MM-yyyy-hh-mm-ss") + ".txt"
$logfile_location = "C:\Users\Chinmay\OneDrive\LogFile_DND\Log.txt"
$Excluir = @( "System Volume Information", "`$RECYCLE.BIN")
$wshell = New-Object -ComObject Wscript.Shell 

#FUnction for timestamping
function Get-TimeStamp { return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date) }

#Function for copy files
function copyTask {
    #check whether F drive has files/folders or not
    if ($source_location) {
        #write-host "Files presents for copy"
        write-output "$(Get-TimeStamp) Files presents for copy" | Out-File $logfile_location -Append

        Copy-Item $source_location\* -Destination $destination_location -Force -Recurse -Exclude $Excluir -ErrorAction Stop
    }
    else {
        write-host "Google drive is empty"
        write-output "$(Get-TimeStamp) Google drive is empty" | Out-File $logfile_location -Append
    }

    
}

copyTask
$source_file_count = Get-ChildItem -Path $source_location
$desti_file_count = Get-ChildItem -Path $destination_location

if ($source_file_count.count -eq $desti_file_count.count) {
    write-output "$(Get-TimeStamp) All folders copied" | Out-File $logfile_location -Append
    $wshell.Popup("Autocopy completed", 10, "Gdrive to Onedrive AutoCopy", 64)
}
else {
    #Write-host "File mismatch"
    write-output "$(Get-TimeStamp) File mismatch" | Out-File .$logfile_location -Append
    $wshell.Popup("AutoCopy file mismatch found", 10, "Gdrive to Onedrive AutoCopy", 48)
    
}