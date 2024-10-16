"""This file defines a reform.

A reform is a set of modifications to be applied to a reference tax and benefit
system to carry out experiments.

See https://openfisca.org/doc/key-concepts/reforms.html
"""

# Import from openfisca-core the objects used to code the legislation in OpenFisca
from openfisca_core.reforms import Reform
from openfisca_core.variables import Variable


class social_security_contribution(Variable):
    # Variable metadata don't need to be redefined. By default, the reference
    # variable metadata will be used.

    def formula(person, period, _parameters):
        """Social security contribution reform.

        Our reform replaces `social_security_contribution` (the "reference"
        variable) by the following variable.
        """
        return person("salary", period) * 0.03


class flat_social_security_contribution(Reform):
    def apply(self):
        """Apply reform.

        A reform always defines an `apply` method that builds the reformed tax
        and benefit system from the reference one. See
        https://openfisca.org/doc/coding-the-legislation/reforms.html#writing-a-reform
        """
        self.update_variable(social_security_contribution)
