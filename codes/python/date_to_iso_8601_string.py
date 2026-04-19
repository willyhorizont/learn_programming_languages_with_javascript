import datetime


def date_to_iso_8601_string(any_date=None):
    return (datetime.datetime.now(datetime.timezone.utc) if (any_date is None) else (any_date.replace(tzinfo=datetime.timezone.utc) if (any_date.tzinfo is None) else any_date.astimezone(datetime.timezone.utc))).isoformat(timespec="milliseconds").replace("+00:00", "Z")


def main():
    print("# iso 8601 string to date in Python")

    print(date_to_iso_8601_string())
    print(date_to_iso_8601_string(datetime.datetime(2023, 5, 10, 15, 30, 45)))
    print(datetime.datetime(2023, 5, 10, 15, 30, 45, tzinfo=datetime.timezone(datetime.timedelta(hours=7))))


if __name__ == "__main__":
    main()
