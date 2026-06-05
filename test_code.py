"""
数学计算工具模块

提供常用的数学统计函数，包括求和、最大值和平均值计算。

使用示例:
    >>> from test_code import calculate_sum, find_max, calculate_average
    >>> data = [1, 2, 3, 4, 5]
    >>> calculate_sum(data)
    15
    >>> find_max(data)
    5
    >>> calculate_average(data)
    3.0
"""

from typing import Union


def calculate_sum(numbers: list[Union[int, float]]) -> Union[int, float]:
    """计算数字列表的总和。

    使用内置 sum() 函数简化实现。

    Args:
        numbers: 包含数字的列表。

    Returns:
        列表中所有数字的总和。

    Raises:
        TypeError: 如果输入不是列表。
        ValueError: 如果列表为空。

    示例:
        >>> calculate_sum([1, 2, 3])
        6
        >>> calculate_sum([1.5, 2.5])
        4.0
    """
    if not isinstance(numbers, list):
        raise TypeError(f"期望列表类型，得到 {type(numbers).__name__}")
    if not numbers:
        raise ValueError("列表不能为空")
    return sum(numbers)


def find_max(numbers: list[Union[int, float]]) -> Union[int, float]:
    """查找数字列表中的最大值。

    使用内置 max() 函数简化实现。

    Args:
        numbers: 包含数字的列表，不能为空。

    Returns:
        列表中的最大值。

    Raises:
        TypeError: 如果输入不是列表。
        ValueError: 如果列表为空。

    示例:
        >>> find_max([1, 2, 3, 4, 5])
        5
        >>> find_max([10, -5, 3])
        10
    """
    if not isinstance(numbers, list):
        raise TypeError(f"期望列表类型，得到 {type(numbers).__name__}")
    if not numbers:
        raise ValueError("列表不能为空")
    return max(numbers)


def calculate_average(numbers: list[Union[int, float]]) -> float:
    """计算数字列表的平均值。

    使用 calculate_sum 函数计算总和，然后除以列表长度。

    Args:
        numbers: 包含数字的列表，不能为空。

    Returns:
        列表中所有数字的平均值。

    Raises:
        TypeError: 如果输入不是列表。
        ValueError: 如果列表为空。

    示例:
        >>> calculate_average([1, 2, 3, 4, 5])
        3.0
        >>> calculate_average([10, 20])
        15.0
    """
    if not isinstance(numbers, list):
        raise TypeError(f"期望列表类型，得到 {type(numbers).__name__}")
    if not numbers:
        raise ValueError("列表不能为空")
    return calculate_sum(numbers) / len(numbers)


if __name__ == "__main__":
    data = [1, 2, 3, 4, 5]
    print("Sum:", calculate_sum(data))
    print("Max:", find_max(data))
    print("Average:", calculate_average(data))
