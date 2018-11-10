function pullouts(name)
for i=1:4
basic('SA', strcat(name, '_SA_fast_pullout', string(i), '.csv'), strcat(name, ' SA fast pullout', string(i)))
end

for i=1:4
basic('LH', strcat(name, '_LH_fast_pullout', string(i), '.csv'), strcat(name, ' LH fast pullout', string(i)))
end

for i=1:4
basic('RH', strcat(name, '_RH_fast_pullout', string(i), '.csv'), strcat(name, ' RH fast pullout', string(i)))
end
