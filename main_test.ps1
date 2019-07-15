Function Start-PIM-GUI{

	<#
		.SYNOPSIS
			This Function creates a GUI interface for CyberArk Administrators.

		.DESCRIPTION
			The GUI initiates once the $Global:TOKEN has been created and the accounts successfully
				authenticates with the Vault. Afterwards, the GUI offers a simple interface for the 
				administrators to execute their tasks.
	#>

	[CmdletBinding()]
	Param()

	Begin{
        $CsvImport = Import-Csv -Delimiter ',' -LiteralPath 'N:\Sec_2018\Coding\PowerShell\PIM GUI\commands.csv'
        $font = New-Object -TypeName System.Drawing.Font("Times New Roman", 18, [System.Drawing.FontStyle]::Bold)
        $Font_Button = New-Object -TypeName System.Drawing.Font("Times New Roman", 11)

		$MainWindow = New-Object -TypeName System.Windows.Forms.Form
		$MainWindow.Text = 'PIM v10 Administrator Window'
		$MainWindow.Width = 600
		$MainWindow.Height = 555
		$MainWindow.AutoSize = $true

		$Button_User = New-Object -TypeName System.Windows.Forms.Button
		$Button_User.Location = New-Object -TypeName System.Drawing.Size(25, 25)
		$Button_User.Size = New-Object -TypeName System.Drawing.Size(200, 75)
		$Button_User.Text = 'User'
        $Button_User.Font = $font

	        $MainWindow.Controls.Add($Button_User)

        $User_Textbox = New-Object -TypeName System.Windows.Forms.TextBox
        $Group_Textbox = New-Object -TypeName System.Windows.Forms.TextBox
        $Label_User_ItemContent = New-Object -TypeName System.Windows.Forms.Label

		$Button_Groups = New-Object -TypeName System.Windows.Forms.Button
		$Button_Groups.Location = New-Object -TypeName System.Drawing.Size(25, 125)
		$Button_Groups.Size = New-Object -TypeName System.Drawing.Size(200, 75)
		$Button_Groups.Text = 'Groups'
        $Button_Groups.Font = $font

	        $MainWindow.Controls.Add($Button_Groups)

		$Button_Accounts = New-Object -TypeName System.Windows.Forms.Button
		$Button_Accounts.Location = New-Object -TypeName System.Drawing.Size(25, 225)
		$Button_Accounts.Size = New-Object -TypeName System.Drawing.Size(200, 75)
		$Button_Accounts.Text = 'Accounts'
        $Button_Accounts.Font = $font

	        $MainWindow.Controls.Add($Button_Accounts)

        $GroupBox_Acc = New-Object -TypeName System.Windows.Forms.GroupBox
        $Button_Cust = New-Object -TypeName System.Windows.Forms.Button

		$Button_Safe = New-Object -TypeName System.Windows.Forms.Button
		$Button_Safe.Location = New-Object -TypeName System.Drawing.Size(25, 325)
		$Button_Safe.Size = New-Object -TypeName System.Drawing.Size(200, 75)
		$Button_Safe.Text = 'Safe'
        $Button_Safe.Font = $font

	        $MainWindow.Controls.Add($Button_Safe)

        $GroupBox_Safe = New-Object -TypeName System.Windows.Forms.GroupBox

		$Button_Exit = New-Object -TypeName System.Windows.Forms.Button
		$Button_Exit.Location = New-Object -TypeName System.Drawing.Size(25, 425)
		$Button_Exit.Size = New-Object -TypeName System.Drawing.Size(200, 75)
		$Button_Exit.Text = 'Exit'
        $Button_Exit.Font = $font

        	$MainWindow.Controls.Add($Button_Exit)
	}

    Process{
        $Button_User.Add_Click({
            Select-User
        })

        $Button_Accounts.Add_Click({
            Select-Accounts
        })

        $Button_Safe.Add_Click({
            Select-Safe
        })

        $Button_Groups.Add_Click({
            Select-Groups
        })
    }

	End{
		[void]$MainWindow.ShowDialog()
	}
}

Function Select-User{
    
    [CmdletBinding()]
    Param()

    Begin{
        $Button_AddUser = New-Object -TypeName System.Windows.Forms.Button
        $Button_AddUser.Location = New-Object -TypeName System.Drawing.Size(250, 25)
        $Button_AddUser.Size = New-Object -TypeName System.Drawing.Size(125, 35)
        $Button_AddUser.Text = 'Add new users'

            $MainWindow.Controls.Add($Button_AddUser)

        $Button_Unlock = New-Object -TypeName System.Windows.Forms.Button
        $Button_Unlock.Location = New-Object -TypeName System.Drawing.Size(250, 65)
        $Button_Unlock.Size = New-Object -TypeName System.Drawing.Size(125, 35)
        $Button_Unlock.Text = 'Unlock User'

            $MainWindow.Controls.Add($Button_Unlock)

        $Button_GetDetails = New-Object -TypeName System.Windows.Forms.Button
        $Button_GetDetails.Location = New-Object -TypeName System.Drawing.Size(250, 105)
        $Button_GetDetails.Size = New-Object -TypeName System.Drawing.Size(125, 35)
        $Button_GetDetails.Text = 'Get User Details'

            $MainWindow.Controls.Add($Button_GetDetails)
    }

    Process{
        $Button_AddUser.add_Click({
            Add-NewUser
        })

        $Button_Unlock.add_Click({
            Unlock-User
        })

        $Button_GetDetails.add_Click({
            Get-UserDetails
        })
    }

    End{}
}

Function Add-NewUser{

	<#
		.SYNOPSIS
			The Function executes the function to add a new user to the vault.
				
		.DESCRIPTION
			See SYNOPSIS.
	#>

	[CmdletBinding()]
	Param()

	Begin{
		$Label_User = New-Object -TypeName System.Windows.Forms.Label
		$Label_User.Text = 'Account Initials:'
		$Label_User.Location = New-Object -TypeName System.Drawing.Point(250, 150)
        $Label_User.Font = $Font_Button
		$Label_User.AutoSize = $true

			$MainWindow.Controls.Add($Label_User)

		$Label_User_ItemContent.Text = ''
		$Label_User_ItemContent.Location = New-Object -TypeName System.Drawing.Point(250, 225)
        $Label_User_ItemContent.Font = $Font_Button
        $Label_User_ItemContent.AutoSize = $true

			$MainWindow.Controls.Add($Label_User_ItemContent)

        $User_Textbox.Width = 100
        $User_Textbox.Height = 50
        $User_Textbox.Location = New-Object -TypeName System.Drawing.Point(250, 175)

            $MainWindow.Controls.Add($User_Textbox)

        $Button_Add = New-Object -TypeName System.Windows.Forms.Button
        $Button_Add.Location = New-Object -TypeName System.Drawing.Size(375, 150)
        $Button_Add.Size = New-Object -TypeName System.Drawing.Size(150, 50)
        $Button_Add.Text = 'Check'
        
        $MainWindow.Controls.Add($Button_Add)
	}

	Process{
        $Button_Add.Add_Click({
            Try{
                $Label_User_ItemContent.Text = ''
                $Label_User_ItemContent.Text = "$($User_Textbox.Text) is created."
                }
            Catch{
                $Label_User_ItemContent.Text = ''
                $Label_User_ItemContent.Text = $_.Exception.Message
                $Label_User_ItemContent.BackColor = [System.Drawing.Color]::FromArgb(206, 74, 1)
                }
        })
	}

    End{
        
    }
}

Function Unlock-User{

	<#
		.SYNOPSIS
			The Function executes the function to unlock a user in the vault.
				
		.DESCRIPTION
			See SYNOPSIS.
	#>

	[CmdletBinding()]
	Param()

	Begin{
		$Label_User = New-Object -TypeName System.Windows.Forms.Label
		$Label_User.Text = 'Account Initials:'
		$Label_User.Location = New-Object -TypeName System.Drawing.Point(250, 150)
        $Label_User.Font = $Font_Button
		$Label_User.AutoSize = $true

			$MainWindow.Controls.Add($Label_User)

		$Label_User_ItemContent.Text = ''
		$Label_User_ItemContent.Location = New-Object -TypeName System.Drawing.Point(250, 225)
        $Label_User_ItemContent.Font = $Font_Button
        $Label_User_ItemContent.AutoSize = $true

			$MainWindow.Controls.Add($Label_User_ItemContent)

        $User_Textbox.Width = 100
        $User_Textbox.Height = 50
        $User_Textbox.Location = New-Object -TypeName System.Drawing.Point(250, 175)

            $MainWindow.Controls.Add($User_Textbox)

        $Button_Add = New-Object -TypeName System.Windows.Forms.Button
        $Button_Add.Location = New-Object -TypeName System.Drawing.Size(375, 150)
        $Button_Add.Size = New-Object -TypeName System.Drawing.Size(150, 50)
        $Button_Add.Text = 'Unlock'
        
        $MainWindow.Controls.Add($Button_Add)
	}

	Process{
        $Button_Add.Add_Click({
            Try{
                $Label_User_ItemContent.Text = ''
                $Label_User_ItemContent.Text = "$($User_Textbox.Text) is unlocked now."
                }
            Catch{
                $Label_User_ItemContent.Text = ''
                $Label_User_ItemContent.Text = $_.Exception.Message
                $Label_User_ItemContent.BackColor = [System.Drawing.Color]::FromArgb(206, 74, 1)
                }
        })
	}

    End{
        
    }
}

Function Get-UserDetails{
    
    <#
		.SYNOPSIS
			The Function retrieves AD information from the entered account initial.
				
		.DESCRIPTION
			See SYNOPSIS.
	#>

	[CmdletBinding()]
	Param()

	Begin{
		$Label_User = New-Object -TypeName System.Windows.Forms.Label
		$Label_User.Text = 'Account Initials:'
		$Label_User.Location = New-Object -TypeName System.Drawing.Point(250, 150)
        $Label_User.Font = $Font_Button
		$Label_User.AutoSize = $true

			$MainWindow.Controls.Add($Label_User)

		$Label_User_ItemContent.Text = ''
		$Label_User_ItemContent.Location = New-Object -TypeName System.Drawing.Point(250, 225)
        $Label_User_ItemContent.Font = $Font_Button
        $Label_User_ItemContent.AutoSize = $true

			$MainWindow.Controls.Add($Label_User_ItemContent)

        $User_Textbox.Width = 100
        $User_Textbox.Height = 50
        $User_Textbox.Location = New-Object -TypeName System.Drawing.Point(250, 175)

            $MainWindow.Controls.Add($User_Textbox)

        $Button_Add = New-Object -TypeName System.Windows.Forms.Button
        $Button_Add.Location = New-Object -TypeName System.Drawing.Size(375, 150)
        $Button_Add.Size = New-Object -TypeName System.Drawing.Size(150, 50)
        $Button_Add.Text = 'Get Details'
        
        $MainWindow.Controls.Add($Button_Add)
	}

	Process{
        $Button_Add.Add_Click({
            Try{
                $Label_User_ItemContent.Text = ''
                $Label_User_ItemContent.Text = Get-ADUser -Identity $User_Textbox.Text | Out-String
                $Label_User_ItemContent.BackColor = [System.Drawing.Color]::FromKnownColor('White')
                }
            Catch{
                $Label_User_ItemContent.Text = ''
                $Label_User_ItemContent.Text = $_.Exception.Message
                $Label_User_ItemContent.BackColor = [System.Drawing.Color]::FromArgb(206, 74, 1)
                }
        })
	}

    End{
        
    }
}

Function Select-Groups{
    
    <#
        .SYNOPSIS
            The BEGIN block creates the buttons for the 'Group' button. The PROCESS block contain the 
                functions to execute the respective button functionality.
    #>

    [CmdletBinding()]
    Param()

    Begin{
        $Button_AddUserToGroup = New-Object -TypeName System.Windows.Forms.Button
        $Button_AddUserToGroup.Location = New-Object -TypeName System.Drawing.Size(250, 25)
        $Button_AddUserToGroup.Size = New-Object -TypeName System.Drawing.Size(125, 35)
        $Button_AddUserToGroup.Text = 'Add Users to Groups'

            $MainWindow.Controls.Add($Button_AddUserToGroup)

        $Button_RemoveUser = New-Object -TypeName System.Windows.Forms.Button
        $Button_RemoveUser.Location = New-Object -TypeName System.Drawing.Size(250, 65)
        $Button_RemoveUser.Size = New-Object -TypeName System.Drawing.Size(125, 35)
        $Button_RemoveUser.Text = 'Remove Users from Groups'

            $MainWindow.Controls.Add($Button_RemoveUser)

        $Button_GroupMember = New-Object -TypeName System.Windows.Forms.Button
        $Button_GroupMember.Location = New-Object -TypeName System.Drawing.Size(250, 105)
        $Button_GroupMember.Size = New-Object -TypeName System.Drawing.Size(125, 35)
        $Button_GroupMember.Text = 'Get Group Members'

            $MainWindow.Controls.Add($Button_GroupMember)
            
        $Button_GroupDetails = New-Object -TypeName System.Windows.Forms.Button
        $Button_GroupDetails.Location = New-Object -TypeName System.Drawing.Size(400, 25)
        $Button_GroupDetails.Size = New-Object -TypeName System.Drawing.Size(125, 35)
        $Button_GroupDetails.Text = 'Get Group Details'

            $MainWindow.Controls.Add($Button_GroupDetails)
    }

    Process{
        $Button_AddUserToGroup.add_Click({
            Add-UserToGroup
        })

        $Button_RemoveUser.add_Click({
            Remove-GroupUser
        })

        $Button_GroupMember.add_Click({
            Get-GroupMember
        })

        $Button_GroupDetails.add_Click({
            Get-GroupDetails
        })
    }

    End{}
}

Function Add-UserToGroup{
    
    <#
		.SYNOPSIS
			The Function executes the function to add a new user to the vault.
				
		.DESCRIPTION
			See SYNOPSIS.
	#>

	[CmdletBinding()]
	Param()

	Begin{
		$Label_User = New-Object -TypeName System.Windows.Forms.Label
		$Label_User.Text = 'Account Initials:'
		$Label_User.Location = New-Object -TypeName System.Drawing.Point(250, 150)
        $Label_User.Font = $Font_Button
		$Label_User.AutoSize = $true

			$MainWindow.Controls.Add($Label_User)

        $Label_Group = New-Object -TypeName System.Windows.Forms.Label
        $Label_Group.Text = 'Group Name:'
        $Label_Group.Location = New-Object -TypeName System.Drawing.Point(250, 175)
        $Label_Group.Font = $Font_Button
        $Label_Group.AutoSize = $true

            $MainWindow.Controls.Add($Label_Group)

		$Label_User_ItemContent.Text = ''
		$Label_User_ItemContent.Location = New-Object -TypeName System.Drawing.Point(250, 275)
        $Label_User_ItemContent.Font = $Font_Button
        $Label_User_ItemContent.AutoSize = $true

			$MainWindow.Controls.Add($Label_User_ItemContent)

        $User_Textbox.Width = 100
        $User_Textbox.Height = 50
        $User_Textbox.Location = New-Object -TypeName System.Drawing.Point(400, 150)

            $MainWindow.Controls.Add($User_Textbox)

        $Group_Textbox.Width = 100
        $Group_Textbox.Height = 50
        $Group_Textbox.Location = New-Object -TypeName System.Drawing.Point(400, 175)

            $MainWindow.Controls.Add($Group_Textbox)

        $Button_Add = New-Object -TypeName System.Windows.Forms.Button
        $Button_Add.Location = New-Object -TypeName System.Drawing.Size(250, 200)
        $Button_Add.Size = New-Object -TypeName System.Drawing.Size(150, 50)
        $Button_Add.Text = 'Add User'
        
        $MainWindow.Controls.Add($Button_Add)
	}

	Process{
        $Button_Add.Add_Click({
            Try{
                $Label_User_ItemContent.Text = ''
                $Label_User_ItemContent.Text = "$($User_Textbox.Text) is added to $($Group_Textbox.Text)."
                $Label_User_ItemContent.BackColor = [System.Drawing.Color]::White
                }
            Catch{
                $Label_User_ItemContent.Text = ''
                $Label_User_ItemContent.Text = $_.Exception.Message
                $Label_User_ItemContent.BackColor = [System.Drawing.Color]::FromArgb(206, 74, 1)
                }
        })
	}

    End{
        
    }
}

Function Remove-GroupUser{
    
    <#
		.SYNOPSIS
			The Function executes the function to remove a user from a group.
				
		.DESCRIPTION
			See SYNOPSIS.
	#>

	[CmdletBinding()]
	Param()

	Begin{
		$Label_User = New-Object -TypeName System.Windows.Forms.Label
		$Label_User.Text = 'Account Initials:'
		$Label_User.Location = New-Object -TypeName System.Drawing.Point(250, 150)
        $Label_User.Font = $Font_Button
		$Label_User.AutoSize = $true

			$MainWindow.Controls.Add($Label_User)

        $Label_Group = New-Object -TypeName System.Windows.Forms.Label
        $Label_Group.Text = 'Group Name:'
        $Label_Group.Location = New-Object -TypeName System.Drawing.Point(250, 175)
        $Label_Group.Font = $Font_Button
        $Label_Group.AutoSize = $true

            $MainWindow.Controls.Add($Label_Group)

		$Label_User_ItemContent.Text = ''
		$Label_User_ItemContent.Location = New-Object -TypeName System.Drawing.Point(250, 275)
        $Label_User_ItemContent.Font = $Font_Button
        $Label_User_ItemContent.AutoSize = $true

			$MainWindow.Controls.Add($Label_User_ItemContent)

        $User_Textbox.Width = 100
        $User_Textbox.Height = 50
        $User_Textbox.Location = New-Object -TypeName System.Drawing.Point(400, 150)

            $MainWindow.Controls.Add($User_Textbox)

        $Group_Textbox.Width = 100
        $Group_Textbox.Height = 50
        $Group_Textbox.Location = New-Object -TypeName System.Drawing.Point(400, 175)

            $MainWindow.Controls.Add($Group_Textbox)

        $Button_Add = New-Object -TypeName System.Windows.Forms.Button
        $Button_Add.Location = New-Object -TypeName System.Drawing.Size(250, 200)
        $Button_Add.Size = New-Object -TypeName System.Drawing.Size(150, 50)
        $Button_Add.Text = 'Remove User'
        
        $MainWindow.Controls.Add($Button_Add)
	}

	Process{
        $Button_Add.Add_Click({
            Try{
                $Label_User_ItemContent.Text = ''
                $Label_User_ItemContent.Text = "$($User_Textbox.Text) was removed from $($Group_Textbox.Text)."
                $Label_User_ItemContent.BackColor = [System.Drawing.Color]::White
                }
            Catch{
                $Label_User_ItemContent.Text = ''
                $Label_User_ItemContent.Text = $_.Exception.Message
                $Label_User_ItemContent.BackColor = [System.Drawing.Color]::FromArgb(206, 74, 1)
                }
        })
	}

    End{
        
    }
}

Function Get-GroupMember{
    <#
		.SYNOPSIS
			The Function retrieves AD information from the entered account initial.
				
		.DESCRIPTION
			See SYNOPSIS.
	#>

	[CmdletBinding()]
	Param()

	Begin{
		$Label_User = New-Object -TypeName System.Windows.Forms.Label
		$Label_User.Text = 'Group Name:'
		$Label_User.Location = New-Object -TypeName System.Drawing.Point(250, 150)
        $Label_User.Font = $Font_Button
		$Label_User.AutoSize = $true

			$MainWindow.Controls.Add($Label_User)

		$Label_User_ItemContent.Text = ''
		$Label_User_ItemContent.Location = New-Object -TypeName System.Drawing.Point(250, 225)
        $Label_User_ItemContent.Font = $Font_Button
        $Label_User_ItemContent.AutoSize = $true

			$MainWindow.Controls.Add($Label_User_ItemContent)

        $User_Textbox.Width = 100
        $User_Textbox.Height = 50
        $User_Textbox.Location = New-Object -TypeName System.Drawing.Point(250, 175)

            $MainWindow.Controls.Add($User_Textbox)

        $Button_Add = New-Object -TypeName System.Windows.Forms.Button
        $Button_Add.Location = New-Object -TypeName System.Drawing.Size(375, 150)
        $Button_Add.Size = New-Object -TypeName System.Drawing.Size(150, 50)
        $Button_Add.Text = 'Get Details'
        
        $MainWindow.Controls.Add($Button_Add)
	}

	Process{
        $Button_Add.Add_Click({
            Try{
                $Label_User_ItemContent.Text = ''
                $Label_User_ItemContent.Text = Get-ADGroupMember -Identity $User_Textbox.Text | Out-String
                $Label_User_ItemContent.BackColor = [System.Drawing.Color]::FromKnownColor('White')
                }
            Catch{
                $Label_User_ItemContent.Text = ''
                $Label_User_ItemContent.Text = $_.Exception.Message
                $Label_User_ItemContent.BackColor = [System.Drawing.Color]::FromArgb(206, 74, 1)
                }
        })
	}

    End{
        
    }
}

Function Get-GroupDetails{
    
    <#
		.SYNOPSIS
			The Function retrieves AD information from the entered account initial.
				
		.DESCRIPTION
			See SYNOPSIS.
	#>

	[CmdletBinding()]
	Param()

	Begin{
		$Label_User = New-Object -TypeName System.Windows.Forms.Label
		$Label_User.Text = 'Group Name:'
		$Label_User.Location = New-Object -TypeName System.Drawing.Point(250, 150)
        $Label_User.Font = $Font_Button
		$Label_User.AutoSize = $true

			$MainWindow.Controls.Add($Label_User)

		$Label_User_ItemContent.Text = ''
		$Label_User_ItemContent.Location = New-Object -TypeName System.Drawing.Point(250, 225)
        $Label_User_ItemContent.Font = $Font_Button
        $Label_User_ItemContent.AutoSize = $true

			$MainWindow.Controls.Add($Label_User_ItemContent)

        $User_Textbox.Width = 100
        $User_Textbox.Height = 50
        $User_Textbox.Location = New-Object -TypeName System.Drawing.Point(250, 175)

            $MainWindow.Controls.Add($User_Textbox)

        $Button_Add = New-Object -TypeName System.Windows.Forms.Button
        $Button_Add.Location = New-Object -TypeName System.Drawing.Size(375, 150)
        $Button_Add.Size = New-Object -TypeName System.Drawing.Size(150, 50)
        $Button_Add.Text = 'Get Details'
        
        $MainWindow.Controls.Add($Button_Add)
	}

	Process{
        $Button_Add.Add_Click({
            Try{
                $Label_User_ItemContent.Text = ''
                $Label_User_ItemContent.Text = Get-ADGroup -Identity $User_Textbox.Text | Out-String
                $Label_User_ItemContent.BackColor = [System.Drawing.Color]::FromKnownColor('White')
                }
            Catch{
                $Label_User_ItemContent.Text = ''
                $Label_User_ItemContent.Text = $_.Exception.Message
                $Label_User_ItemContent.BackColor = [System.Drawing.Color]::FromArgb(206, 74, 1)
                }
        })
	}

    End{
        
    }
}

Function Select-Accounts{
    
    [CmdletBinding()]
    Param()

    Begin{
        $Customer = $CsvImport.customer | Select-Object -Unique

		$GroupBox_Acc.Text = 'Tenant List:'
		$GroupBox_Acc.Location = New-Object -TypeName System.Drawing.Point(250, 25)
        $GroupBox_Acc.Size = New-Object -TypeName System.Drawing.Size(270, 500)

			$MainWindow.Controls.Add($GroupBox_Acc)
    }

    Process{
        $Tenant_Counter = 0
        $Tenant_Counter_2nd = 0

        $Customer | ForEach-Object {
            $Tenant = $_
            if (-not ($Tenant -eq "")){
                $Tenant_Button = New-Object -TypeName System.Windows.Forms.Button
                if ($Tenant_Counter -lt 12){
                    $Tenant_Button.Location = New-Object -TypeName System.Drawing.Size(5, (15 + ($Tenant_Counter++ * 40)))
                }
                else{
                    $Tenant_Button.Location = New-Object -TypeName System.Drawing.Size(140, (15 + ($Tenant_Counter_2nd++ * 40)))
                }
	            $Tenant_Button.Size = New-Object -TypeName System.Drawing.Size(125, 35)
	            $Tenant_Button.Text = $Tenant
                $Tenant_Button.Font = $Font_Button
                                
                $Tenant_Button.add_Click({
                    $CsvImport = Import-Csv -Delimiter ',' -LiteralPath 'N:\Sec_2018\Coding\PowerShell\PIM GUI\commands.csv'
                    $Customer_Domain = $CsvImport | Where-Object {$_.command_name -match "Admin $Tenant"} | Select-Object -Property command_name
                    $DomainCounter = 0
                    Write-Verbose -Verbose "Test Tenant $Tenant"
                    Write-Verbose -Verbose "Test Domain $($Customer_Domain.command_name)"
                    
		            $Button_Cust.Location = New-Object -TypeName System.Drawing.Size(545, (25 + ($DomainCounter++ * 40)))
    		        $Button_Cust.Size = New-Object -TypeName System.Drawing.Size(125, 35)
	    	        $Button_Cust.Text = $Customer_Domain.command_name
                    $Button_Cust.Font = $Font_Button
                    $MainWindow.Controls.Add($Button_Cust)
                    
                    #$Customer_Domain.command_name | ForEach-Object {
                    #    $Domain = $_
                    #    Write-Verbose -Verbose "Tenant $Domain"
                    #    $Button_Cust = New-Object -TypeName System.Windows.Forms.Button
		            #    $Button_Cust.Location = New-Object -TypeName System.Drawing.Size(545, (25 + ($DomainCounter++ * 40)))
    		        #    $Button_Cust.Size = New-Object -TypeName System.Drawing.Size(125, 35)
	    	        #    $Button_Cust.Text = $Domain
                    #    $Button_Cust.Font = $Font_Button
                    #
                    #    $Button_Cust.add_Click({
                    #        #$FunctionIndex = [array]::IndexOf(($CsvImport).command_name, $Domain)
                    #        #$Customer_Function = ($CsvImport[$FunctionIndex]).object_command
                    #    
                    #        #Invoke-Expression -Command $Customer_Function
                    #        Write-Verbose -Verbose "Test $Domain"
                    #    }.GetNewClosure())
                    #    $MainWindow.Controls.Add($Button_Cust)
                    #}
                }.GetNewClosure())
	            $GroupBox_Acc.Controls.Add($Tenant_Button)
            }
        }        
    }

    End{}
}

Function Select-Safe{
    
    [CmdletBinding()]
    Param()

    Begin{
        $Customer = $CsvImport.customer | Select-Object -Unique

		$GroupBox_Safe.Text = 'Tenant List:'
		$GroupBox_Safe.Location = New-Object -TypeName System.Drawing.Point(250, 25)
        $GroupBox_Safe.Size = New-Object -TypeName System.Drawing.Size(270, 500)

			$MainWindow.Controls.Add($GroupBox_Safe)}

    Process{
        $Tenant_Counter = 0
        $Tenant_Counter_2nd = 0  
        Foreach ($Tenant in $Customer){
            if (-not ($Tenant -eq "")){
                $Tenant_Button = New-Object -TypeName System.Windows.Forms.Button
                if ($Tenant_Counter -lt 12){
                    $Tenant_Button.Location = New-Object -TypeName System.Drawing.Size(5, (15 + ($Tenant_Counter++ * 40)))
                }
                else{
                    $Tenant_Button.Location = New-Object -TypeName System.Drawing.Size(140, (15 + ($Tenant_Counter_2nd++ * 40)))
                }
	            $Tenant_Button.Size = New-Object -TypeName System.Drawing.Size(125, 35)
	            $Tenant_Button.Text = $Tenant
                $Tenant_Button.Font = $Font_Button
                                
                $Tenant_Button.add_Click({
                    $Customer_Domain = ($CsvImport | Where-Object {$_.command_name -match "Admin $Tenant"}).command_name
                    $DomainCounter = 0
                    Foreach ($Domain in $Customer_Domain){
                        $Button_Cust = New-Object -TypeName System.Windows.Forms.Button
		                $Button_Cust.Location = New-Object -TypeName System.Drawing.Size(545, (25 + ($DomainCounter++ * 40)))
    		            $Button_Cust.Size = New-Object -TypeName System.Drawing.Size(125, 35)
	    	            $Button_Cust.Text = $Domain
                        $Button_Cust.Font = $Font_Button

                	        $MainWindow.Controls.Add($Button_Cust)
                    
                        $Button_Cust.add_Click({
                            $FunctionIndex = [array]::IndexOf(($CsvImport).command_name, $Domain)
                            $Customer_Function = ($CsvImport[$FunctionIndex]).object_command
                        
                            #Invoke-Expression -Command $Customer_Function
                            Write-Verbose -Verbose "Test $Domain"
                        })
                    }
                })
	            $GroupBox_Safe.Controls.Add($Tenant_Button)
            }
        }
    }

    End{}
}


Function Add-Buttons{

    <#
        .SYNOPSIS
            The function standardizes the button creation for the PIM GUI. It requires already a window where the buttons will be placed.

        .DESCRIPTION
            The function takes several key parameter to locate and 'text' the button.

        .Parameter WindowFrame
            The parameter 
    #>
    
    [Cmdletbinding()]
    Param(
            [Parameter(
                    Mandatory = $True,
                    ValueFromPipeline = $True)]
                $WindowFrame,
            
            [Parameter(
                    Mandatory = $True,
                    ValueFromPipelineByPropertyName = $True)]
                [string]$Name,
            
            [Parameter(
                    Mandatory = $True,
                    ValueFromPipelineByPropertyName = $True)]
                [int]$xLocation,

            [Parameter(
                    Mandatory = $True,
                    ValueFromPipelineByPropertyName = $True)]
                [int]$yLocation,

            [Parameter(
                    Mandatory = $True,
                    ValueFromPipelineByPropertyName = $True)]
                [int]$Width,

            [Parameter(
                    Mandatory = $True,
                    ValueFromPipelineByPropertyName = $True)]
                [int]$Height,

            [Parameter(
                    Mandatory = $False,
                    ValueFromPipelineByPropertyName = $True)]
                [string]$FontButton
                )

    Begin{
        $Button = New-Object -TypeName System.Windows.Forms.Button
        if ((15 + ($yLocation * 40)) -le 485){
            $Button.Location = New-Object -TypeName System.Drawing.Size($xLocation, (15 + ($yLocation * ($Height + 5))))
        }
        else{
            $Button.Location = New-Object -TypeName System.Drawing.Size($Width + ($xLocation + 10), (15 + ($yLocation * ($Height + 5))))
        }
        $Button.Text = $Name
        $Button.Font = $FontButton
        $Button.Size = New-Object -TypeName System.Drawing.Size($Width, $Height)

        $WindowFrame.Controls.add($Button)
    }

    Process{}

    End{}
}