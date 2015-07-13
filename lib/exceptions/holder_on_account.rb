# Definition of Holder on account exception
class HolderOnAccount < BaseException
  def output
    ['Transaction Error',
     'The Holder Selected already exists on the selected account',
     'Please Try again.']
  end
end
