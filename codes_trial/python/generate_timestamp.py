import datetime


def generate_timestamp(precise=False):
    if precise:
        # ((2025//(07|Jul)//(21|Mon)||(02:13 PM|14:13):26.219000))
        return datetime.datetime.now().strftime("((%Y//(%m|%b)//(%d|%a)||((%I:%M %p|%H:%M):%S.%f)))")
    # ((2025//(07|Jul)//(21|Mon)||(02:13 PM|14:13)))
    return datetime.datetime.now().strftime("((%Y//(%m|%b)//(%d|%a)||(%I:%M %p|%H:%M)))")


if __name__ == "__main__":
    print(generate_timestamp())
    print(generate_timestamp(True))
