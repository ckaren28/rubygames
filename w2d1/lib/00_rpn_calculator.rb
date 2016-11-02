

class RPNCalculator
  OPERATORS = [:+, :-, :*, :/]

  def initialize
    @stack = []
  end

  def perform_op(op_sym)
    raise "calculator is empty" unless @stack.length >= 2

    right_op = @stack.pop
    left_op = @stack.pop

    case op_sym
    when :+
      @stack << left_op + right_op
    when :-
      @stack << left_op - right_op
    when :*
      @stack << left_op * right_op
    when :/
      @stack << left_op.fdiv(right_op)
    else
      raise Argument_Error.new("No operation #{op_sym}")
    end
  end

  def push(num)
    @stack << num
  end

  def plus
    perform_op(:+)
  end

  def minus
    perform_op(:-)
  end

  def times
    perform_op(:*)
  end

  def divide
    perform_op(:/)
  end

  def value
    @stack.last
  end

  def operator?(char)
    OPERATORS.include?(char.to_sym)
  end


  def tokens(string)
    chars = string.split(" ")
    chars.map { |char| operator?(char) ? char.to_sym : Integer(char) }
  end


  def evaluate(string)
    tokens(string).each do |token|
      case token
      when Integer
        @stack.push(token)
      when Symbol
      perform_op(token)

      end
    end

     value
  end

end
