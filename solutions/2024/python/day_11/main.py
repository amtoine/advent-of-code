from typing import List


def naive(nums: List[int], nb_blinks: int) -> int:
    for _ in range(nb_blinks):
        next = []

        for i in nums:
            if i == 0:
                next.append(1)
            else:
                s = str(i)
                n = len(s)

                if n % 2 == 0:
                    next.extend([int(s[:n//2]), int(s[n//2:])])
                else:
                    next.append(i * 2024)

        nums = next

    return len(nums)


def memo(nums: List[int], nb_blinks: int) -> int:
    mem = {}

    def aux(i: int, b: int) -> int:
        if b == 0:
            return 1

        if i == 0:
            next = [1]
        else:
            s = str(i)
            n = len(s)

            if n % 2 == 0:
                next = [int(s[:n//2]), int(s[n//2:])]
            else:
                next = [i * 2024]

        tot = 0

        for n in next:
            k = f"{n}-{b}"
            if k not in mem:
                res = aux(n, b - 1)
                mem[k] = res
            tot += mem[k]

        return tot

    return sum(aux(n, nb_blinks) for n in nums)


if __name__ == "__main__":
    from typing import Any, Callable, Tuple
    from time import perf_counter_ns

    def timeit(f: Callable, *args, **kwargs) -> Tuple[Any, int]:
        start = perf_counter_ns()
        res = f(*args, **kwargs)
        end = perf_counter_ns()
        return (res, end - start)

    input = "5688 62084 2 3248809 179 79 0 172169"
    nums = [int(tok) for tok in input.split(' ')]

    for b in range(0, 75 + 1, 5):
        res, time = timeit(memo, nums, b)
        print(f"memo for {b} done in {time}: {res}")

    for b in range(30):
        res, time = timeit(naive, nums, b)
        print(f"naive for {b} done in {time}: {res}")
