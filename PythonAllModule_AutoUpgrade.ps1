<#The command lines will popmout listed python modules to a text file requirement.txt
Then will upgrade each nmodule automatically
Make sure the correct path before running the script#>


pip freeze > .\requirements.txt
$f = Get-Content C:\Users\n0278588\requirements.txt
Clear-Content C:\Users\n0278588\requirements.txt

foreach($i in $f){

$i = $i -replace '==','>='
$i | Out-File "C:\Users\n0278588\requirements.txt" -Append 
write-host $i}

pip install -r requirements.txt --upgrade