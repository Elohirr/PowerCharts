function New-ChartArea {
<#
.SYNOPSIS
Creates a new ChartArea object for use in a Chart object.

.DESCRIPTION
Uses the [Windows.Forms.DataVisualization] .NET class to instantiate a new ChartArea object.  The returned Chart object must be placed in a Chart to be visible.

.PARAMETER AreaName
The name to be assigned to the newly created ChartArea object.

.PARAMETER BackColor
The background color to be applied to the ChartArea object.  Default is 'Black'

.PARAMETER XAxis
If specified, the Title of the X-axis that will be displayed.

.PARAMETER YAxis
If specified, the Title of the Y-axis that will be displayed.

.EXAMPLE

.COMPONENT
[System.Drawing]
[System.Windows.Forms.DataVisualization]

.NOTES
Author:         Keith C. Jakobs, MCP [Elohir(r)]
Change Log:
    2021-05-13
        [KCJ]:
                * Create function scaffold
                * Help framework & content
                * Initial Parameter definitions & Help content for...
                    - Title
                    - XAxis and YAxis
    2021-05-17
        [KCJ]:
                * Fix backcolor code to use correct property of ChartArea
#>
    [CmdletBinding()]
    [OutputType([System.Windows.Forms.DataVisualization.Charting.ChartArea])]
    param (

        # AreaName : Name to be assigned to ChartArea
        [Parameter(Mandatory=$false)]
        [Alias("Name")]
        [string]
        $AreaName = "Default",

        # BackColor : Background color of area
        [Parameter(Mandatory=$false,HelpMessage="Data must be a valid color from System.Drawing.Color")]
        [Alias("BackgroundColor")]
        [System.Drawing.Color]
        $BackColor = [System.Drawing.Color]::Black,

        # XAxis :  Label to display for X-axis
        [Parameter(Mandatory=$false)]
        [string]
        $XAxis,

        # YAxis : Label to display for Y-axis
        [Parameter(Mandatory=$false)]
        [string]
        $YAxis

    )

    begin {

        # [System.Windows.Forms.DataVisualization.Charting.Axis] | gm

    }

    process {

        $NewChartArea = New-Object -TypeName System.Windows.Forms.DataVisualization.Charting.ChartArea

        # Set ChartArea name
        $NewChartArea.Name = $AreaName

        # Add any defined axis titles
        $NewChartArea.AxisX.Title = $XAxis
        $NewChartArea.AxisY.Title = $YAxis

        # Set the background color of the ChartArea object
        $NewChartArea.BackColor = $BackColor

    }

    end {

        # return new object to calling routine
        return $NewChartArea

    }
}