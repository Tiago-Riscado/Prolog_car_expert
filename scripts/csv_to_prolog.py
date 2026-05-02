"""
csv_to_prolog.py
Converts carros.csv into a Prolog knowledge base (carros.pl).

Usage:
    python scripts/csv_to_prolog.py
    python scripts/csv_to_prolog.py --input data/carros.csv --output data/carros.pl
"""

import argparse
import pandas as pd
import unidecode


# ------------------------------------------------------------------ #
# Column names after splitting the semicolon-separated CSV
# ------------------------------------------------------------------ #

COLUMNS = [
    "Marca", "Modelo", "Tipo", "Combustivel", "Impacto", "Custo",
    "Ano", "Km", "Cor", "Cor_Tipo", "Portas", "Dimensao",
    "Capacidade_Carga", "ArCondicionado", "TipoCaixa", "Tracao",
    "Cavalos", "Preco", "Tecnologia", "Seguranca",
]


def normalizar(texto: str) -> str:
    """Removes accents and lowercases a string."""
    return unidecode.unidecode(str(texto).strip()).lower()


def parse_lista(texto: str) -> list:
    """Splits a semicolon-separated feature string into a normalised list."""
    return [normalizar(f) for f in str(texto).split(";") if f.strip()]


def linha_para_facto(row) -> str:
    """Converts one CSV row into a Prolog carro/2 fact."""
    marca   = f"{normalizar(row['Marca'])}_{normalizar(row['Modelo'])}".replace(" ", "_").replace("-", "_")
    tecnologia = parse_lista(row["Tecnologia"])
    seguranca  = parse_lista(row["Seguranca"])
    caracteristicas = tecnologia + seguranca

    return (
        f"carro({marca}, [\n"
        f"    tipo({normalizar(row['Tipo'])}),\n"
        f"    combustivel({normalizar(row['Combustivel'])}),\n"
        f"    ano({row['Ano']}),\n"
        f"    km({row['Km']}),\n"
        f"    cor({normalizar(row['Cor'])}_{normalizar(row['Cor_Tipo'])}),\n"
        f"    portas({row['Portas']}),\n"
        f"    arcondicionado({normalizar(row['ArCondicionado'])}),\n"
        f"    tipodecaixa({normalizar(row['TipoCaixa'])}),\n"
        f"    tracao({normalizar(row['Tracao'])}),\n"
        f"    cavalos({row['Cavalos']}),\n"
        f"    preco({int(float(str(row['Preco']).replace(',', '.')))}),\n"
        f"    caracteristicas({caracteristicas})\n"
        f"]).\n"
    )


def convert(input_path: str, output_path: str):
    df = pd.read_csv(input_path, encoding="utf-8", sep=";")

    # Normalise column names
    df.columns = COLUMNS[:len(df.columns)]

    factos = "\n".join(df.apply(linha_para_facto, axis=1))

    with open(output_path, "w", encoding="utf-8") as f:
        f.write(factos)

    print(f"✓ {len(df)} facts written to {output_path}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Convert carros.csv to Prolog knowledge base.")
    parser.add_argument("--input",  default="data/carros.csv", help="Path to input CSV")
    parser.add_argument("--output", default="data/carros.pl",  help="Path to output .pl file")
    args = parser.parse_args()
    convert(args.input, args.output)
