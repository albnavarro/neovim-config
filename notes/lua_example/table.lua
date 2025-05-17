-- :so %

local keyA = "a"
local t2 = { ["a"] = 1, ["b"] = 2, 10, ["d"] = 3, 4 }

-- Le chiavi non numeriche vengono ignorate nel loro complesso,
-- analogamente agli indici numerici inferiori a 1. Inoltre,
-- gli spazi vuoti tra gli indici causano arresti.
-- L'ordinamento è deterministico, in base alla grandezza numerica.
for k, v in ipairs(t2) do
    print(k, v)
end

print("--")

-- Restituisce coppie chiave-valore ed è utilizzato principalmente per tabelle associative.
-- Tutte le chiavi vengono conservate, ma l'ordine non è specificato.
for k, v in pairs(t2) do
    print(k, v)
end

print("--")
print(t2[keyA])
print(t2["b"])
