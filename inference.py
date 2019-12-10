from clips import *
from pprint import pprint
from transform import euclidDistance
import numpy as np


def infer(facts):
    m, lines, adjacent_lines, points = facts
    # Initialize
    env = Environment()

    rules = []
    string = ""
    # Load rule
    with open('shapes.clp', 'r') as file:
        string = file.read().replace('\n', '')
        rules = string.split(';')

    for rule in rules:
        env.build(rule)

    # Assert adjacent
    adjacent_count = len(adjacent_lines)
    env.assert_string(f'(adjacent {adjacent_count})')

    # Assert line
    id_lines = dict()
    for id_line, line in enumerate(lines):
        x1, y1, x2, y2 = line
        length = euclidDistance(x1, x2, y1, y2)
        gradient = m[id_line] if m[id_line] != np.inf else 10 ** 5

        id_lines[tuple(line.flat)] = id_line
        env.assert_string(
            f'(line (integer {id_line}) (integer {length}) (integer {gradient}))')

    for adj in adjacent_lines:
        tupled_adj_line = tuple(adj)
        meet_string = f'(meet (integer {id_lines[tupled_adj_line[0]]}) (integer {id_lines[tupled_adj_line[1]]}))'
        env.assert_string(meet_string)
        meet_string = f'(meet (integer {id_lines[tupled_adj_line[1]]}) (integer {id_lines[tupled_adj_line[0]]}))'
        env.assert_string(meet_string)

    # Assert points
    for point in points:
        env.assert_string(f'(point (integer {point[0]}) (integer {point[1]}))')

    # Run
    env.run(200)

    fact_string = '----FACTS----\n'
    # Check facts
    for fact in env.facts():
        # <class 'clips.facts.ImpliedFact'>
        # Convert to string
        fact_string += str(fact) + '\n'

    return fact_string


def rules():
    # Initialize
    env = Environment()

    rules = []
    string = ""
    # Load rule
    with open('shapes.clp', 'r') as file:
        string = file.read().replace('\n', '')
        rules = string.split(';')

    for rule in rules:
        env.build(rule)

    str_rules = '----RULES----\n'
    for rule in env.rules():
        str_rules += str(rule)

    return str_rules
