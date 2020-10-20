"""
This file defines a reform.

A reform is a set of modifications to be applied to a reference tax and benefit system to carry out experiments.

See https://openfisca.org/doc/key-concepts/reforms.html
"""

# Import from openfisca-core the Python objects used to code the legislation in OpenFisca
from openfisca_core.periods import MONTH
from openfisca_core.reforms import Reform
from openfisca_core.variables import Variable

# Import the Entities specifically defined for this tax and benefit system
from openfisca_country_template.entities import Person


class new_tax(Variable):
    value_type = float
    entity = Person
    definition_period = MONTH
    label = "New tax"
    reference = "https://law.gov.example/new_tax"  # Always use the most official source

    def formula(person, period, _parameters):
        """
        New tax reform.

        Our reform adds a new variable `new_tax` that is calculated based on
        the current `income_tax`.
        """
        return person("income_tax", period) + 100.0


class add_new_tax(Reform):
    def apply(self):
        """
        Apply reform.

        A reform always defines an `apply` method that builds the reformed tax
        and benefit system from the reference one.

        See https://openfisca.org/doc/coding-the-legislation/reforms.html#writing-a-reform
        """
        self.add_variable(new_tax)
