"""This module demonstrates the new generic Entity Link syntax."""

from openfisca_core.periods import ETERNITY
from openfisca_core.variables import Variable

from openfisca_country_template.entities import Employer, Person


# ----------------------------------------------------------------------------
# 1. Structural Variables (Holding IDs)
# ----------------------------------------------------------------------------
class mother_id(Variable):
    value_type = int
    entity = Person
    definition_period = ETERNITY
    default_value = -1
    label = "ID of the person's mother (Intra-entity link)"


class employer_id(Variable):
    value_type = int
    entity = Person
    definition_period = ETERNITY
    default_value = -1
    label = "ID of the person's employer (Inter-entity link)"


# ----------------------------------------------------------------------------
# 2. Functional Variables Using Links
# ----------------------------------------------------------------------------
class person_mother_salary(Variable):
    value_type = float
    entity = Person
    definition_period = ETERNITY
    label = "Salary extracted directly from the person's mother"

    def formula(person, period, _parameters):
        """Fetch mother's salary."""
        # Fetches `salary` dynamically by resolving `person.mother_id`
        # and retrieving the corresponding salary on the target person instance.
        return person.mother.get("salary", period)


class employer_total_payroll(Variable):
    value_type = float
    entity = Employer
    definition_period = ETERNITY
    label = "Total salary paid by an employer to all its employees"

    def formula(employer, period, _parameters):
        """Return total employee salaries."""
        # Uses explicit One2ManyLink. Resolves all persons holding this employer's ID
        # and aggregates their dynamically retrieved salaries.
        return employer.employees.sum("salary", period)


class employer_female_payroll(Variable):
    value_type = float
    entity = Employer
    definition_period = ETERNITY
    label = "Total salary paid by an employer, but conditionally only to females"

    def formula(employer, period, _parameters):
        """Return total employee salaries for females."""
        # Similar logic: we can filter One2ManyLink aggregations natively
        # via explicit conditions.
        is_female = employer.simulation.persons("is_female", period)
        return employer.employees.sum("salary", period, condition=is_female)


class is_female(Variable):
    value_type = bool
    entity = Person
    definition_period = ETERNITY
    label = "Is the person a female?"
    default_value = False
