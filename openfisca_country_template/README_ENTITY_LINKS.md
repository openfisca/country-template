# Demonstrating Explicit Entity Links

This branch `feat/entity-links-demo` demonstrates how to implement completely arbitrary entity networks in OpenFisca using the **Phase 5 Country Package API**.

Instead of being restricted to strictly hierarchical standard groups like `Households` containing `Persons`, you can now implement graph-like structures such as:
1. **Intra-entity links**: Connecting rows inside the exact same population (e.g. `person -> mother_id`).
2. **Inter-entity networks**: Connecting persons to non-hierarchical unique groups (e.g. `person -> employer_id`).

## What was added in this PR?

### 1. New Link Definitions (`openfisca_country_template/entities.py`)

Using the new `Many2OneLink` and `One2ManyLink` syntax from `openfisca_core`:
- Introduced a new SingleEntity `Employer`.
- Linked `Person` to another `Person` via a `mother` link.
- Linked `Person` to `Employer` via an `employer` link.
- Linked `Employer` back to `Person` via an `employees` link.

```python
Person.add_link(Many2OneLink(
    name="mother",
    link_field="mother_id",
    target_entity_key="person"
))

Employer.add_link(One2ManyLink(
    name="employees",
    link_field="employer_id",
    target_entity_key="person"
))
```

### 2. Powerful Dynamic Variables (`openfisca_country_template/variables/links_demo.py`)

Added structural mapping variables holding scalar identifiers (`mother_id`, `employer_id`).

These allow you to write extremely readable code that magically resolves across groups using the new `.get()` and `.sum()` operators!

**Look at how simple querying across arbitrary links has become:**
```python
def formula(person, period, parameters):
    # Fetch exactly the mother's salary vector.
    # Automatically joins `person -> mother_id -> target.salary`.
    return person.mother.get("salary", period)
```

**And executing filtered grouping from one entity to another:**
```python
def formula(employer, period, parameters):
    # Fetch all employees attached to this employer and sum their salaries
    # You can conditionally apply boolean masks instantly!
    is_female = employer.simulation.persons("is_female", period)
    return employer.employees.sum("salary", period, condition=is_female)
```

### 3. Integrated Example Tests (`openfisca_country_template/tests/test_links_demo.py`)

Shows exactly how you pass data structurally matching these IDs into `SimulationBuilder().build_from_dict()` so that OpenFisca correctly links everything!
