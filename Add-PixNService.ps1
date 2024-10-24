# Define the path where gamelist.xml is located, two levels up from the current script, inside system\es-menu
$xmlFilePath = "..\..\system\es_menu\gamelist.xml"

# Check if the file exists
if (Test-Path $xmlFilePath) {
    # Read the XML content into a string array
    $xmlContent = Get-Content $xmlFilePath

    # Check if the entry ".PixN Update Service." already exists in the file
    if (-not ($xmlContent -like "*<name>.PixN Update Service.</name>*")) {
        # Define the content to insert
        $newEntry = @'
    <game>
        <path>./pixn-rb-update-service.menu</path>
        <name>.PixN Update Service.</name>
        <desc>Script to update the Team Pixel Nostalgia supplied content.</desc>
        <image>./media/pixn-rb-update-service-logo.png</image>
        <marquee>./media/pixn-rb-update-service-logo.png</marquee>
        <rating>0</rating>
        <releasedate />
        <developer>Team Pixel Nostalgia</developer>
        <publisher>Team Pixel Nostalgia</publisher>
        <genre>Script</genre>
        <playcount />
        <lastplayed />
        <gametime />
        <lang>en</lang>
        <region>wr</region>
    </game>
'@

        # Find the index of the line containing "</gameList>"
        $endTagIndex = $xmlContent.IndexOf("</gameList>")

        # Insert the new entry before the </gameList> line
        if ($endTagIndex -ge 0) {
            $xmlContent = $xmlContent[0..($endTagIndex-1)] + $newEntry + $xmlContent[$endTagIndex..($xmlContent.Count-1)]
            
            # Write the updated content back to the file
            Set-Content -Path $xmlFilePath -Value $xmlContent -Force
            Write-Output "The entry has been added successfully."
        } else {
            Write-Output "</gameList> tag not found in the file."
        }
    } else {
        Write-Output "The entry '.PixN Update Service.' already exists."
    }
} else {
    Write-Output "gamelist.xml file not found at the specified location."
}
