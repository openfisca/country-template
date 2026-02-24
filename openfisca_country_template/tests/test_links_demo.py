"""Test explicit Links mapping in simulation payloads.

This examples test demonstrates how simulation payloads map correctly
with explicit Links.

This module provides integration tests for the entity linking feature.
"""

from openfisca_core.simulations import SimulationBuilder

from openfisca_country_template import CountryTaxBenefitSystem


def test_links_demo():
    """Test the correct resolution and aggregation of explicit entity links."""
    tax_benefit_system = CountryTaxBenefitSystem()

    # 3 persons:
    # idx 0: Mother (id 0) - female, works for employer 0
    # idx 1: Child (has mother 0) - not female, works for employer 0
    # idx 2: Other (id 2) - female, works for employer 1

    simulation = SimulationBuilder().build_from_dict(
        tax_benefit_system,
        {
            "persons": {
                "mother": {
                    "salary": {"2024-01": 50000.0},
                    "is_female": {"2024-01": True},
                    "mother_id": {"2024-01": -1},  # Unknown mother
                    "employer_id": {"2024-01": 0},
                },
                "child": {
                    "salary": {"2024-01": 30000.0},
                    "is_female": {"2024-01": False},
                    "mother_id": {"2024-01": 0},  # Mother is index 0
                    "employer_id": {"2024-01": 0},
                },
                "other": {
                    "salary": {"2024-01": 40000.0},
                    "is_female": {"2024-01": True},
                    "mother_id": {"2024-01": -1},
                    "employer_id": {"2024-01": 1},
                },
            },
            "employers": {
                "big_corp": {"contractors": ["mother", "child"]},  # id 0
                "small_biz": {"contractors": ["other"]},  # id 1
            },
        },
    )

    # Check Many2OneLink Person -> Mother
    # The child (index 1) should have its mother_salary be 50000.0
    mother_salaries = simulation.calculate("person_mother_salary", "2024-01")
    assert mother_salaries[1] == 50000.0  # noqa: S101

    # Check One2ManyLink Employer -> Employees sum aggregation
    # big_corp (id 0) has mother and child, so payroll = 50000 + 30000 = 80000
    # small_biz (id 1) has other, so payroll = 40000
    total_payroll = simulation.calculate("employer_total_payroll", "2024-01")
    assert total_payroll[0] == 80000.0  # noqa: S101
    assert total_payroll[1] == 40000.0  # noqa: S101

    # Check conditional aggregation: just female payroll
    female_payroll = simulation.calculate("employer_female_payroll", "2024-01")
    assert female_payroll[0] == 50000.0  # noqa: S101
    assert female_payroll[1] == 40000.0  # noqa: S101
