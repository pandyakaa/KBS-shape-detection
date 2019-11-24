from clips import *

# Initialize
env = Environment()

rules = []
string = ""
# Load rule
with open('shapes.clp', 'r') as file:
    string = file.read().replace('\n', '')
    rules = string.split(';')
    print(len(rules))

for rule in rules:
    env.build(rule)


env.assert_string('(adjacent 6)')
env.assert_string('(line (integer 1) (integer 5) )')
env.assert_string('(line (integer 2) (integer 5) )')
env.assert_string('(line (integer 3) (integer 5) )')
env.assert_string('(line (integer 4) (integer 5) )')
env.assert_string('(line (integer 5) (integer 5) )')
env.assert_string('(line (integer 6) (integer 5) )')


# Run
env.run(200)


# Check facts
for fact in env.facts():
    # <class 'clips.facts.ImpliedFact'>
    # Convert to string
    print(str(fact))
