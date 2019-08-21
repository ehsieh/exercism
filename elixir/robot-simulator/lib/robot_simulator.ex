defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @directions [:north, :south, :east, :west]
  @left_movements  %{ north: :west, west: :south, south: :east, east: :north }
  @right_movements %{ north: :east, east: :south, south: :west, west: :north }

  defguard is_coordinate(x, y) when is_integer(x) and is_integer(y)

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create do
    create(:north, {0, 0})
  end

  def create(direction, _position) when direction not in @directions do
    { :error, "invalid direction" }
  end

  def create(direction, {x, y} = position) when is_coordinate(x, y) do
    %{direction: direction, position: position}
  end

  def create(_direction, _position) do
    { :error, "invalid position" }
  end

  def simulate(robot, ""), do: robot

  def simulate(robot, "L" <> instructions) do
    new_direction = Map.fetch!(@left_movements, robot.direction)
    %{robot | direction: new_direction} |> simulate(instructions)
  end

  def simulate(robot, "R" <> instructions) do
    new_direction = Map.fetch!(@right_movements, robot.direction)
    %{robot | direction: new_direction} |> simulate(instructions)
  end

  def simulate(robot, "A" <> instructions) do
    robot |> advance |> simulate(instructions)
  end

  def simulate(_invalid, _robot) do
    { :error, "invalid instruction" }
  end

  defp advance(%{direction: direction, position: {x, y}} = robot) do
    case direction do
      :north -> %{robot | position: {x, y + 1}}
      :south -> %{robot | position: {x, y - 1}}
      :east  -> %{robot | position: {x + 1, y}}
      :west  -> %{robot | position: {x - 1, y}}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%{direction: d}), do: d

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%{position: p}),  do: p
end
