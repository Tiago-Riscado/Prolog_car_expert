# Prolog Car Expert System

An expert system in **SWI-Prolog** that helps users find a car matching their preferences, explore statistics, and look up car specifications — backed by a knowledge base of ~5700 vehicles generated from a CSV dataset.

---

## Structure

```
prolog-car-expert/
│
├── perito.pl               # Expert system — menus, queries, statistics
│
├── data/
│   ├── carros.csv          # Raw dataset (~5700 cars, semicolon-separated)
│   └── carros.pl           # Prolog knowledge base (generated from CSV)
│
├── scripts/
│   └── csv_to_prolog.py    # Python script to regenerate carros.pl from CSV
│
├── requirements.txt
└── .gitignore
```

---

## How to Run

### Requirements
- [SWI-Prolog](https://www.swi-prolog.org/Download.html)

### Start the expert system

```bash
swipl perito.pl
?- menu.
```

### Menu options

```
1. Discover your Car     — filter by type, fuel, year, km, colour, price, features...
2. Car Statistics        — count by type / fuel / gearbox / drivetrain
3. Car Specifications    — look up full details by name
4. Exit
```

---

## Regenerating the Knowledge Base

If you update `carros.csv`, regenerate `carros.pl` with:

```bash
pip install -r requirements.txt
python scripts/csv_to_prolog.py
# or with custom paths:
python scripts/csv_to_prolog.py --input data/carros.csv --output data/carros.pl
```

---

## Knowledge Base Format

Each car is a Prolog fact `carro/2`:

```prolog
carro(porsche_panamera, [
    tipo(sedan),
    combustivel(gasolina),
    ano(2018),
    km(127334),
    cor(branco_fosco),
    portas(3),
    arcondicionado(sim),
    tipodecaixa(automatica),
    tracao(traseira),
    cavalos(304),
    preco(72805),
    caracteristicas([ecomode, paineldigital, sos, gps, autopilot,
                     airbags, assistentetravagem, controletracao])
]).
```

---

## Features supported in car search

| Attribute | Options |
|-----------|---------|
| Type | sedan · coupe · cuv · suv · hatch_back · supercar |
| Fuel | gasolina · eletrico · diesel |
| Year | range (min / max) |
| Km | range (min / max) |
| Colour | Preto · Branco · Prata · Azul · Vermelho + finish |
| Doors | 3 · 5 |
| AC | sim · nao |
| Gearbox | manual · automatica |
| Drivetrain | dianteira · traseira · as_quatro |
| Horsepower | range (min / max) |
| Price (€) | range (min / max) |
| Features | autopilot · gps · paineldigital · assistenteestacionamento · ecomode · ... |

---

## Tech stack

`SWI-Prolog` `Python` `Pandas` `Unidecode`
