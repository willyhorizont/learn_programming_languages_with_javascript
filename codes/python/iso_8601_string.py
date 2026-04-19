import datetime


def get_iso_8601_string_v1():
    return f'{(current_timestamp := datetime.datetime.now(datetime.timezone.utc)).strftime("%Y-%m-%dT%H:%M:%S.")}{current_timestamp.microsecond // 1000:03d}Z'


def get_iso_8601_string_v2():
    return datetime.datetime.now(datetime.timezone.utc).isoformat(timespec="milliseconds").replace("+00:00", "Z")


def main():
    from utils import get_iso_8601_string

    print("# ISO 8601 String in Python")

    print(f'{(current_timestamp := datetime.datetime.now(datetime.timezone.utc)).strftime("%Y-%m-%dT%H:%M:%S.")}{current_timestamp.microsecond // 1000:03d}Z')
    print(datetime.datetime.now(datetime.timezone.utc).isoformat(timespec="milliseconds").replace("+00:00", "Z"))
    print(get_iso_8601_string_v1())
    print(get_iso_8601_string_v2())
    print(get_iso_8601_string())


if __name__ == "__main__":
    main()
