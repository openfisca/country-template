"""This file defines the entities needed by our legislation.

Taxes and benefits can be calculated for different entities: persons, household,
companies, etc.

See https://openfisca.org/doc/key-concepts/person,_entities,_role.html
"""

from openfisca_core.entities import build_entity

Household = build_entity(
    key="household",
    plural="households",
    label="All the people in a family or group who live together in the same place.",
    doc="""
    Household is an example of a group entity.
    A group entity contains one or more individuals.
    Each individual in a group entity has a role (e.g. parent or children).
    Some roles can only be held by a limited number of individuals (e.g. a
    'first_parent' can only be held by one individual), while others can
    have an unlimited number of individuals (e.g. 'children').

    Example:
        Housing variables (e.g. housing_tax') are usually defined for a group
        entity such as 'Household'.

    Usage:
        Check the number of individuals of a specific role (e.g. check if there
        is an 'adult' with household.nb_persons(Household.ADULT)).
        Calculate a variable applied to each individual of the group entity
        (e.g. calculate the 'salary' of each member of the 'Household' with:
            salaries = household.members("salary", period = MONTH)
            sum_salaries = household.sum(salaries)).

    For more information, see: https://openfisca.org/doc/coding-the-legislation/50_entities.html
    """,
    roles=[
        {
            "key": "adult",
            "plural": "adults",
            "label": "Adult",
            "doc": "The adults of the household.",
        },
        {
            "key": "child",
            "plural": "children",
            "label": "Child",
            "doc": "The non-adults of the household.",
        },
    ],
)

Person = build_entity(
    key="person",
    plural="persons",
    label="An individual. The minimal entity on which legislation can be applied.",
    doc="""
    Variables like 'salary' and 'income_tax' are usually defined for the entity
    'Person'.

    Usage:
        Calculate a variable applied to a 'Person' (e.g. access the 'salary' of
        a specific month with person("salary", "2017-05")).

    For more information, see: https://openfisca.org/doc/coding-the-legislation/50_entities.html
    """,
    is_person=True,
)

entities = [Household, Person]
