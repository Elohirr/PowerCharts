function New-ChartSeries {
    <#
    .SYNOPSIS
    Creates a new ChartSeries object for use in a ChartArea object.
    
    .DESCRIPTION
    Uses the [Windows.Forms.DataVisualization] .NET class to instantiate a new ChartSeries object.  The returned ChartSeries object must be placed in a ChartArea to be visible.
    
    .PARAMETER SeriesName
    The name to be assigned to the newly created ChartArea object.
    
    .PARAMETER ChartType
    The type of chart that will be presented by this data series.  Valid (supported) chart types can be enumerated from System.Windows.Forms.DataVisualization.Charting.SeriesChartType.  If no ChartType is specified, a 'line' chart will be presented by the newly created Series.
    
    .PARAMETER BorderStyle
    The style of the border that will be drawn around the 
    
    .EXAMPLE
    
    .COMPONENT
    [System.Drawing]
    [System.Windows.Forms.DataVisualization]
    
    .NOTES
    Author:         Keith C. Jakobs, MCP [Elohir(r)]
    Change Log:
        2021-05-16
            [KCJ]:
                    * Create function scaffold
                    * Help framework & content
                    * Initial Parameter definitions & Help content for...
                        - Name
                        - ChartType
        2021-05-17
        [KCJ]:  
                    * Change default ChartType to Line
                    * 
    #>
        [CmdletBinding()]
        [OutputType([System.Windows.Forms.DataVisualization.Charting.Series])]
        param (
    
            # SeriesName : Name to be assigned to Series
            [Parameter(Mandatory=$false)]
            [Alias("Name")]
            [string]
            $SeriesName = "DefaultData",
    
            # ChartType : Chart Type from System.Windows.Forms.DataVisualization.Charting.SeriesChartType
            [Parameter(Mandatory=$false)]
            [ValidateSet("Line","Bar","Column")]
            [System.Windows.Forms.DataVisualization.Charting.SeriesChartType]
            $ChartType = [System.Windows.Forms.DataVisualization.Charting.SeriesChartType]::Line
        )
        
        begin {

            $NewSeries = New-Object -TypeName System.Windows.Forms.DataVisualization.Charting.Series

            if ($null -eq $NewSeries) {
                Write-Error "Unable to create new data Series object." -Category ResourceUnavailable -CategoryTargetName '$NewSeries' 
                return $null
            }
    
        }
        
        process {

            $NewSeries.name                 = $SeriesName
            $NewSeries.ChartType            = $ChartType
            $NewSeries.BorderDashStyle      = [System.Windows.Forms.DataVisualization.Charting.ChartDashStyle]::solid
            $NewSeries.BorderWidth          = 3
            $NewSeries.BorderColor          = [System.Drawing.Color]::DarkBlue
            $NewSeries.IsVisibleinLegend    = $false

        }
        
        end {
    
            return $NewSeries
            
        }
    }