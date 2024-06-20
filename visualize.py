import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import sys
import os


def plot_queries(data_file, scale_factor, num_iterations):
    # Read the CSV file into a DataFrame
    df = pd.read_csv(data_file)

    # Plot queries 1 to 11
    plt.figure(figsize=(12, 6))
    sns.boxplot(x="query", y="time", data=df[df["query"].between(1, 11)])
    plt.title(
        f"Boxplot of Execution Times for Queries 1 to 11\nScale Factor: {scale_factor}, Number of Iterations: {num_iterations}"
    )
    plt.xlabel("Query")
    plt.ylabel("Execution Time (seconds)")
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.savefig("queries_1_to_11_boxplot.png")
    plt.show()

    # Plot queries 12 to 22
    plt.figure(figsize=(12, 6))
    sns.boxplot(x="query", y="time", data=df[df["query"].between(12, 22)])
    plt.title(
        f"Boxplot of Execution Times for Queries 12 to 22\nScale Factor: {scale_factor}, Number of Iterations: {num_iterations}"
    )
    plt.xlabel("Query")
    plt.ylabel("Execution Time (seconds)")
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.savefig("queries_12_to_22_boxplot.png")
    plt.show()


if __name__ == "__main__":
    if len(sys.argv) != 4:
        print(
            "Usage: python plot_benchmark.py <data_file> <scale_factor> <num_iterations>"
        )
        sys.exit(1)

    data_file = sys.argv[1]
    scale_factor = sys.argv[2]
    num_iterations = sys.argv[3]

    if not os.path.isfile(data_file):
        print(f"File not found: {data_file}")
        sys.exit(1)

    plot_queries(data_file, scale_factor, num_iterations)
