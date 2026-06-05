import csv

# movies.dat
with open('ml-1m/movies.dat', encoding='latin-1') as f_in, \
     open('import/movies.csv', 'w', newline='', encoding='utf-8') as f_out:

    writer = csv.writer(f_out)
    writer.writerow(['movieId', 'title', 'genres'])

    for line in f_in:
        writer.writerow(line.strip().split('::'))

# ratings.dat
with open('ml-1m/ratings.dat', encoding='latin-1') as f_in, \
     open('import/ratings.csv', 'w', newline='', encoding='utf-8') as f_out:

    writer = csv.writer(f_out)
    writer.writerow(['userId', 'movieId', 'rating', 'timestamp'])

    for line in f_in:
        writer.writerow(line.strip().split('::'))

# users.dat
with open('ml-1m/users.dat', encoding='latin-1') as f_in, \
     open('import/users.csv', 'w', newline='', encoding='utf-8') as f_out:

    writer = csv.writer(f_out)
    writer.writerow(['userId', 'gender', 'age', 'occupation'])

    for line in f_in:
        parts = line.strip().split('::')
        writer.writerow(parts[:4])

print("CSV files created successfully!")