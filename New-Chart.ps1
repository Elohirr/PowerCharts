Add-Type -AssemblyName System.Windows.Forms.DataVisualization
Add-Type -AssemblyName System.Drawing

function New-Chart {
<#
.SYNOPSIS
Creates a new Chart object for use in a UI dialog.

.DESCRIPTION
Uses the [Windows.Forms.DataVisualization] .NET class to instantiate a new chart object for use in UI forms and dialogs.  The returned Chart object must be placed in a form to be visible.

.PARAMETER Width
Width of the Chart object being created, measured in pixels.

.PARAMETER Height
Height of the Chart object being created, measured in pixels.

.PARAMETER ChartTitle
Displayed name of the Chart Object. Can be blank.

.PARAMETER ChartFont
Font that will be used to display chart text.  Will default to 12 point Verdana if not specified.  Use [System.Drawing.FontFamily]::Families to enumerate available fonts on the local system.

.PARAMETER TitleAlignment
Defines how the display name, if present, will be aligned within the chart object, both horizontal & vertical.  Valid values are enumerated from [enum]::GetValues("System.Drawing.ContentAlignment")

.PARAMETER ChartBackgroundColor
The color that will be used for the chart background.  This value will also be used to set the background color of the ChartArea object.  If a different color is desired for the ChartArea object, it can either be overriden with code, or a the ChartObject can be created without a ChartArea (using -IncludeChartArea $false), and adding a custom ChartArea object.  The default value for ChartBackground color is 'WhiteSmoke'.

.PARAMETER ChartTextColor
The color that will be used for Title and non-series text.  Default is 'RoyalBlue'

.PARAMETER IncludeChartArea
A boolean value that indicates if the chart object should also be created and added.  The default value is $true, which will include a 'Default' ChartArea within the returned Chart object.  If you wish to add multiple ChartArea objects, and/or customize the name of the default ChartArea object, then this should be set to $false, and ChartAreas should be added manually using New-ChartArea().

.PARAMETER IncludeLegend
A boolean value that indicates if the chart object should include a Legend

.EXAMPLE

.COMPONENT
[System.Drawing]
[System.Windows.Forms.DataVisualization]

.NOTES
Author:     Keith C. Jakobs, MCP [Elohir(r)]
Change Log:
    2021-05-13
        [KCJ]:
            * Create function scaffold
            * Help framework & content
            * Initial Parameter definitions & Help content for...
                - Width & Height
                - Title, including font and alignment
                - Background & text colors
                - Include ChartArea & Legend options
    2021-05-14
        [KCJ]:
            * Help content update (IncludeChartArea parameter)
            * Add logic to support default ChartArea & Legend
    2021-05-17:
        [KCJ]:
            * Set ChartArea BackColor to be same as ChartBackgroundColor

#>
    [CmdletBinding()]
    [OutputType([System.Windows.Forms.DataVisualization.Charting.Chart])]
    param (

        # Width : Width of generated chart
        [Parameter(Mandatory=$true,HelpMessage="Width must be an intege > 0.")]
        [Alias("w")]
        [int16]
        [ValidateScript({$_ -gt 0})]
        $Width,

        # Height : Height of generated chart
        [Parameter(Mandatory=$true,HelpMessage="Height must be an integer > 0.")]
        [Alias("h")]
        [int16]
        [ValidateScript({$_ -gt 0})]
        $Height,

        # ChartTitle : Display name of chart element
        [Parameter(Mandatory=$false)]
        [Alias("Title")]
        [string]$ChartTitle,

        # ChartFont : Font used in chart text
        [Parameter(Mandatory=$false,HelpMessage="See help for list of valid font styles.")]
        [Alias("Font")]
        [string]$ChartFont = "Verdana,12pt",

        # TitleAlignment : Alignment of ChartTitle text
        [Parameter(Mandatory=$false)]
        [Alias("Align")]
        [ValidateSet("TopLeft", "TopCenter", "TopRight", "MiddleLeft", "MiddleCenter", "MiddleRight", "BottomLeft", "BottomCenter", "BottomRight")]
        [System.Drawing.ContentAlignment]
        $TitleAlignment = [System.Drawing.ContentAlignment]::TopCenter,

        # ChartBackgroundColor : Color of chart background
        [Parameter(Mandatory=$false,HelpMessage="Data must be a valid color from System.Drawing.Color")]
        [Alias("BackgroundColor")]
        [System.Drawing.Color]
        $ChartBackgroundColor = [System.Drawing.Color]::WhiteSmoke,

        # ChartTextColor : Color of primary, non-series specific text
        [Parameter(Mandatory=$false,HelpMessage="Data must be a valid color from System.Drawing.Color")]
        [Alias("TextColor")]
        [System.Drawing.Color]
        $ChartTextColor = [System.Drawing.Color]::RoyalBlue,

        # IncludeChartArea : Should ChartArea object be included
        [Parameter(Mandatory=$false)]
        [boolean]
        $IncludeChartArea = $true,

        # IncludeLegend : Should ChartLegend object be included
        [Parameter(Mandatory=$false)]
        [boolean]
        $IncludeLegend = $false

    )

    begin {

        # [System.AppDomain]::CurrentDomain.GetAssemblies() | Where-Object Location | Sort-Object -Property FullName | Select-Object -Property FullName, Location, GlobalAssemblyCache, IsFullyTrusted | Out-GridView

        # Verify required class libraries are available
        #$LoadedAssemblies = [System.AppDomain]::CurrentDomain.GetAssemblies()
        #$DrawLibrary = $LoadedAssemblies | Where-Object FullName -like "*System.Drawing*"
        #$ChartLibrary = $LoadedAssemblies | Where-Object FullName -like "*System.Windows.Forms.DataVisualization*"

    }

    process {

        # Create new chart object and verify success
        $NewChart = New-Object System.Windows.Forms.DataVisualization.Charting.Chart

        if ($null -eq $NewChart) {
            Write-Error "Unable to create new chart object." -Category ResourceUnavailable -CategoryTargetName '$NewChart'
            return $null
        }

        # Set properties for $NewChart
        $NewChart.Width     = $Width
        $NewChart.Height    = $Height
        $NewChart.BackColor = $ChartBackgroundColor

        # Set Chart Title properties, if a title is provided
        if (-Not [String]::IsNullOrEmpty($ChartTitle)) {

            $NewChart.Titles.Add($ChartTitle)
            $NewChart.Titles[0].Font = $ChartFont
            $NewChart.Titles[0].Alignment = $TitleAlignment
            $NewChart.Titles[0].ForeColor = $ChartTextColor
        }

        # Add ChartArea Object, if requested
        if ($IncludeChartArea)  {

            $DefaultChartArea = New-ChartArea -AreaName "Default" -BackColor $ChartBackgroundColor
            $NewChart.ChartAreas.Add($DefaultChartArea)

        }

        # Add Legend, if requested
        if ($IncludeLegend) {

            $DefaultLegend = New-Object -TypeName System.Windows.Forms.DataVisualization.Charting.Legend
            $DefaultLegend.Name = "Legend"
            $NewChart.Legends.Add($DefaultLegend)

        }

    }

    end {

        return $NewChart

    }
}