class StepsController < ApplicationController
  def sort
    step = Step.find(params[:step_id])
    step.update(step_params)
  end

  private
	  def step_params
      params.require(:step).permit(:procedure, :details, :step_image, :procedure_num_position)
	  end
end
