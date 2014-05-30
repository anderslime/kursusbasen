class ApplicationPresenter

  delegate :t, :to => :I18n

  def initialize(object, template)
    @object = object
    @template = template
  end

  private

  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  def h
    @template
  end
end
