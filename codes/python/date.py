import datetime

print(datetime.datetime(2025, 7, 21, 14, 13, 26, (219 * 1000)))

print(datetime.datetime(year=2025, month=7, day=21, hour=14, minute=13, second=26, microsecond=(219 * 1000)))


def iso_8601_string_to_date(iso_string_8601=None):
    if iso_string_8601 is None:
        iso_string_8601 = datetime.datetime.now(datetime.timezone.utc).isoformat(timespec="milliseconds").replace("+00:00", "Z")

    return datetime.datetime.fromisoformat(iso_string_8601.replace("Z", "+00:00"))


def main():
    print("# iso 8601 string to date in Python")

    print(datetime.datetime.now(datetime.timezone.utc))
    print(datetime.datetime.now())
    print(iso_8601_string_to_date())
    print(iso_8601_string_to_date("2025-07-20T21:03:18.068Z"))


if __name__ == "__main__":
    main()
