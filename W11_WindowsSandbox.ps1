################################################################################################
# This script can be used to install Windows Sandbox on Windows 10 & 11                        #
# Editor : Christopher Mogis                                                                   #
# Date : 09/6/2022                                                                             #
# Version 1.0                                                                                  #
# - Initial version                                                                            #
################################################################################################

#Variables
#$Date = Get-Date
$ComputerInfo = Get-ComputerInfo

        Write-Output ""
        $continue = $true
        while ($continue)
        {
          write-host "---------------------- Windows SandBox Installation -----------------------"
          write-host "1. Prerequisites check" -ForegroundColor Cyan
          write-host "2. Install Windows Sandbox" -ForegroundColor Cyan
          write-host "x. exit" -ForegroundColor Yellow
          write-host "---------------------------------------------------------------------------"
          $choix = read-host "Choose an action :"
          switch ($choix){
            #Prerequisites for used Windows SandBox
            "1" {
                #Windows Version
                Write-Output ""
                Write-Output  "### Check Operating System ###"
                Write-Output ""
                $WinVer = $ComputerInfo.WindowsProductName
                if($WinVer -eq "Windows 10 Enterprise" -OR "Windows 10 Professional" )
                    {
                    Write-Host "Your Operating system is compatible with Windows Sandbox" -ForegroundColor Green <# Action to perform if the condition is true #>
                    Write-Host "Windows version installed : $Winver" -ForegroundColor Yellow
                    }
                else 
                    {
                    Write-Host "$WinVer installed on $($ComputerInfo.CsName) is not compatible with Windows Sandbox" -ForegroundColor Red <# Action when all if and elseif conditions are false #>
                    }

                #Virtual Machine
                $CoreCPU = $ComputerInfo.CsSystemFamily
                if($CoreCPU -ge "Virtual Machine"  )
                    {
                Write-Output ""
                Write-Output  "### Check Nested virtualization for Virtual Machine ###"
                Write-Output ""
                Write-Host "For used Windows Sandbox on virtual michine, please check if nested virtualization is activated" -ForegroundColor Yellow <# Action to perform if the condition is true #>
                    }
                
                #CPU Architecture
                Write-Output ""
                Write-Output  "### Check CPU Configuration ###"
                Write-Output ""
                $CoreCPU = $ComputerInfo.CsNumberOfLogicalProcessors
                if($CoreCPU -ge "3"  )
                    {
                    Write-Host "The CPU on $($ComputerInfo.CsName) is compatible with Windows Sandbox" -ForegroundColor Green <# Action to perform if the condition is true #>
                    Write-Host "Number of Core : $CoreCPU" -ForegroundColor Yellow
                    }
                else 
                    {
                    Write-Host "The CPU on $($ComputerInfo.CsName) is not compatible with Windows Sandbox" -ForegroundColor Red <# Action when all if and elseif conditions are false #>
                    Write-Host "Number of Core : $CoreCPU. Microsoft recommends having a processor with at least 4 cores" -ForegroundColor Yellow
                    }

                #RAM Available
                Write-Output ""
                Write-Output  "### Check Memory Ram Installed ###"
                Write-Output ""
                $RamMemory = $ComputerInfo.CsTotalPhysicalMemory
                if($RamMemory -gt "4222190592")
                    {
                    Write-Host "The Quantity of Memory Ram installed on $($ComputerInfo.CsName) is ready with Windows Sandbox" -ForegroundColor Green <# Action to perform if the condition is true #>
                    }
                else 
                    {
                    Write-Host "The amount of memory installed on your computer $($ComputerInfo.CsName) is not enough to run Windows Sandbox" -ForegroundColor Red <# Action when all if and elseif conditions are false #>
                    Write-Host "Microsoft recommends having at least 4 GB of memory" -ForegroundColor Yellow
                    }
                Write-Output ""
                }

                #Option 2 : Windows Sandbox installation
            "2" {
                    Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online
                    Write-Host "After installation, please select Exit !" -ForegroundColor Green
                    Write-Output ""
                }
                #Option x : Exit menu
            "x" {$continue = $false}
            default {Write-Host "Invalid choice" -ForegroundColor Red}
          }
        }
