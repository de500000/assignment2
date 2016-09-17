Code.compiler_options(ignore_module_conflict: true)

defmodule Ex04 do
  require Integer

  ##############################################################################
  # 3: 3 questions,  20 points available #
  ########################################

  @doc """
  Here's a `reduce` function you can use in the following exercises.
  You may not use any Elixir library functions unless specifically allowed
  in the notes for an exercise.

      iex> Ex04.reduce [1, 2, 3, 4], 0, &(&1 + &2)
      10

      iex> Ex04.reduce [1, 2, 3, 4], &(&1 + &2)
      10

      iex> Ex04.reduce [1, 2, 3, 4], [], &[ &1 | &2 ]
      [ 4, 3, 2, 1 ]

  """

  def reduce([ h | t ],  func),        do: reduce(t, h, func)
  def reduce([ ], state, _func),       do: state
  def reduce([ h | t ], state, func),  do: reduce(t, func.(h, state), func)


  ##############################################################################
  # 4.1:  5 points #
  ##################

  @doc """
  Use `reduce` to reverse a list. (there's a hint above)

      iex> Ex04.reverse [ 5, 4, 3, 2, 1 ]
      [ 1, 2, 3, 4, 5 ]

  """
  def reverse(list) do
	reduce(list, [], &[&1|&2]) 
  end

  ##############################################################################
  # 4.2:  5 points #
  ##################
  @doc """
  Use `reduce` to find the minimum of a list of numbers.

      iex> Ex04.list_min [ 5, 2, 7, 9 ]
      2

      iex> Ex04.list_min [ 5, 2, -7, 9 ]
      -7

  """ 
  # I renamed min to list_min
  def list_min([h | t]), do: list_min(t, h) 

  defp list_min([], result), do: result 

  defp list_min([h | t], result) when result < h do
	list_min(t, result)
  end

  defp list_min([h | t], _result), do: list_min(t, h) 
  

  ##############################################################################
  # 4.3: 10 points #
  ##################
  @doc """
  Given a list of integers, return a two element tuple. The first element
  is a list of the even numbers from the list. The second is a list of
  the odd numbers. You may use the library functions `Integer.is_even` and
  `Integer.is_odd`, and you can use the `reverse` function you defined
  above. Feel free to write helper functions if you want.

      iex> Ex04.even_odd [ 1, 2, 3, 4, 5 ]
      { [ 2, 4],  [ 1, 3, 5 ] }

  Hint: you're taking a list and converting it into something else. What function
  helps you do that. And, if you use that function, what does it return? That
  return value will be the thing you have to manipulate.
  """

  #filter
  def filter(list, filter_fn) do
  	reduce(list, [], filter_fn) |> reverse
  end
  
  #only_even_number
  defp only_even_number(value, result) do
      	cond do
    		Integer.is_even(value) -> [ value | result ]
    		true -> result
    	end
  end
  
  #only_odd_number
  defp only_odd_number(value, result) do
	cond do
		Integer.is_odd(value) -> [ value | result ]
		true -> result
	end
  end
  
  #even_odd
  def even_odd(list) do  
	even_number = filter(list, &only_even_number/2)
	odd_number  = filter(list, &only_odd_number/2)
	{ even_number, odd_number } 
  end
  

  ###########################
  # IGNORE FROM HERE TO END #
  ###########################

  @after_compile __MODULE__

  def __after_compile__(_env, bytecode) do
    File.write("Elixir.Ex04.beam", bytecode)
  end

end


ExUnit.start
defmodule TestEx04 do
  use ExUnit.Case
  doctest Ex04
end

