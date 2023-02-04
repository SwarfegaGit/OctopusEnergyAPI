$Tarrifs = Invoke-RestMethod -Uri https://api.octopus.energy/v1/products/SILVER-FLEX-22-11-25

foreach ($DNO in '_A', '_B', '_C', '_D', '_E', '_F', '_G', '_H', '_J', '_K', '_L', '_M', '_N', '_P') {

    # Regions taken from https://www.energy-stats.uk/dno-region-codes-explained/
    $Region = switch ($DNO) {
        '_A' {'Eastern England'}
        '_B' {'East Midlands'}
        '_C' {'London'}
        '_D' {'Merseyside and Northern Wales'}
        '_E' {'West Midlands'}
        '_F' {'North Eastern England'}
        '_G' {'North Western England'}
        '_H' {'Southern England'}
        '_J' {'South Eastern England'}
        '_K' {'Southern Wales'}
        '_L' {'South Western England'}
        '_M' {'Yorkshire'}
        '_N' {'Southern Scotland'}
        '_P' {'Northern Scotland'}
    }

    $ETarrif = $Tarrifs.single_register_electricity_tariffs.$($DNO).direct_debit_monthly
    $GTarrif = $Tarrifs.single_register_gas_tariffs.$($DNO).direct_debit_monthly
    
    [PSCustomObject]@{
        code = $Region
        estandard_unit_rate_inc_vat = $ETarrif.standard_unit_rate_inc_vat
        estanding_charge_inc_vat = $ETarrif.standing_charge_inc_vat
        gstandard_unit_rate_inc_vat = $GTarrif.standard_unit_rate_inc_vat
        gstanding_charge_inc_vat = $GTarrif.standing_charge_inc_vat
    }
}
