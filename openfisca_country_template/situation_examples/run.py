# -*- coding: utf-8 -*-

from openfisca_country_template import CountryTaxBenefitSystem
from openfisca_core.simulation_builder import SimulationBuilder
from . import couple

tax_benefit_system = CountryTaxBenefitSystem()
simulation_builder = SimulationBuilder()
simulation = simulation_builder.build_from_entities(tax_benefit_system, couple)

print (simulation.calculate('total_taxes', '2017-01'))
print (simulation.calculate('total_benefits', '2017-01'))
