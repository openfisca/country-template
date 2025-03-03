"""This file defines variables for the modelled legislation.

A variable is a property of an Entity such as a Person, a Household…

See https://openfisca.org/doc/key-concepts/variables.html
"""

# Import from openfisca-core the objects used to code the legislation in OpenFisca
from openfisca_core.holders import set_input_divide_by_period
from openfisca_core.periods import MONTH
from openfisca_core.populations import DIVIDE
from openfisca_core.variables import Variable

# Import the Entities specifically defined for this tax and benefit system
from openfisca_country_template.entities import Household, Person


# This variable is a pure input: it doesn't have a formula
class salary(Variable):
    value_type = float
    entity = Person
    definition_period = MONTH
    # Optional attribute. Allows user to declare a salary for a year. OpenFisca
    # will spread the yearly amount over the months contained in the year.
    set_input = set_input_divide_by_period
    label = "Salary"
    reference = "https://law.gov.example/salary"  # Always use the most official source


# This variable is a pure input: it doesn't have a formula
class capital_returns(Variable):
    value_type = float
    entity = Person
    definition_period = MONTH
    # Optional attribute. Allows user to declare capital returns for a year.
    # OpenFisca will spread the yearly returns over the months within a year.
    set_input = set_input_divide_by_period
    label = "Capital returns"
    reference = (
        "https://law.gov.example/capital_return"  # Always use the most official source
    )


class disposable_income(Variable):
    value_type = float
    entity = Household
    definition_period = MONTH
    label = "Actual amount available to the household at the end of the month"
    # Some variables represent quantities used in economic models, and not
    # defined by law. Always give the source of your definitions.
    reference = "https://stats.gov.example/disposable_income"

    def formula(household, period, _parameters):
        """Disposable income."""
        # Household's job returns is the sum of all its members' salary.
        salary = household.sum(household.members("salary", period))
        # Household's capital returns is the sum of all its members' capital returns.
        capital_returns = household.sum(household.members("capital_returns", period))
        # Pension is an age-tested amount given to non-working people in the household.
        pension = household.sum(household.members("pension", period))
        # Basic income is a lump sum given any adult regardless of income.
        basic_income = household.sum(household.members("basic_income", period))
        # Housing allowance is an amount given to people the household for rent.
        housing_allowance = household("housing_allowance", period)
        # Parenting allowance is an amount given to the household for childraise.
        parenting_allowance = household("parenting_allowance", period)
        # Income tax is the sum of all household members' income tax.
        income_tax = household.sum(household.members("income_tax", period))
        # Housing tax is a household's payment for housing.
        housing_tax = household("housing_tax", period, [DIVIDE])
        # Social security contribution is the sum of all household members'
        # contribution to the financing of the social security.
        social_security_contribution = household.sum(
            household.members("social_security_contribution", period)
        )

        return (
            salary
            + capital_returns
            + pension
            + basic_income
            + housing_allowance
            + parenting_allowance
            - income_tax
            - housing_tax
            - social_security_contribution
        )
