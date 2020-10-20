"""
This file defines a reform to add a dynamic variable, based on input data.

A reform is a set of modifications to be applied to a reference tax and benefit system to carry out experiments.

See https://openfisca.org/doc/key-concepts/reforms.html
"""

# Import from openfisca-core the Python objects used to code the legislation in OpenFisca
from openfisca_core.periods import MONTH
from openfisca_core.reforms import Reform
from openfisca_core.variables import Variable

# Import the Entities specifically defined for this tax and benefit system
from openfisca_country_template.entities import Person


def create_dynamic_variable(
        name,
        value_type,
        entity,
        default_value,
        definition_period,
        label,
        reference,
        ):
    """Create new variable dynamically."""

    NewVariable = type(name, (Variable,), {
        "value_type": value_type,
        "entity": entity,
        "default_value": default_value,
        "definition_period": definition_period,
        "label": label,
        "reference": reference,
        })

    return NewVariable


class add_dynamic_variable(Reform):
    def apply(self):
        """
        Apply reform.

        A reform always defines an `apply` method that builds the reformed tax
        and benefit system from the reference one.

        See https://openfisca.org/doc/coding-the-legislation/reforms.html#writing-a-reform
        """
        NewVariable = create_dynamic_variable(
            name = "goes_to_school",
            value_type = bool,
            entity = Person,
            default_value = True,
            definition_period = MONTH,
            label = "The person goes to school (only relevant for children)",
            reference = "https://law.gov.example/goes_to_school",
            )

        self.add_variable(NewVariable)
