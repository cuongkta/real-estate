defmodule RealEstateWeb.CronJobController do
  use RealEstateWeb, :controller

  def cron_work(messasge) do 
  	IO.puts(messasge)
  end 
end 