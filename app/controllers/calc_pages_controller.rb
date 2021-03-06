class CalcPagesController < ApplicationController
  def calc_apartment
    @apartments = Apartment.paginate(page: params[:page])
    @anaprtments = Anaprtment.all
    @capartments = Capartment.all
  end
  def calc_apartments_print
    @apartments = Apartment.all
    @anaprtments = Anaprtment.all
    @capartments = Capartment.all
  end
  def calc_earths
    @earths = Earth.paginate(page: params[:page])
    @anearths = Aneart.all
    @cearths = Cearth.all
  end
  def calc_earths_print
    @earths = Earth.all
    @anearths = Aneart.all
    @cearths = Cearth.all
  end
  def calc_houses
    @houses = House.paginate(page: params[:page])
    @anhouses = Anhousehold.all
    @chouse = Chouse.all
  end
  def calc_houses_print
    @houses = House.all
    @anhouses = Anhousehold.all
    @chouse = Chouse.all
  end
end
