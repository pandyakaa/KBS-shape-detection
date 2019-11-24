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

for rule in rules :     
    env.build(rule)

env.assert_string('(adjacent 3)')
env.assert_string('(line 1 5)')
env.assert_string('(line 2 5)')
env.assert_string('(line 3 5)')



# Run
for i in range(0,20):
    print(env.run(100))
    env.refresh()


# Check facts
for fact in env.facts():
    # <class 'clips.facts.ImpliedFact'>
    # Convert to string
    print(str(fact))