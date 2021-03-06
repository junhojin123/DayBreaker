class Scheduler

  attr_accessor :tasks, :max_hours_per_day, :min_hours_per_task, :max_hours_per_task

  def initialize(tasks, user_preferences={})
    @tasks              = tasks
    @max_hours_per_day  = user_preferences.fetch(:max_hours_per_day,  8)
    @min_hours_per_task = user_preferences.fetch(:min_hours_per_task, 1)
    @max_hours_per_task = user_preferences.fetch(:max_hours_per_task, 4)
  end

  def call
    prioritized_tasks = prioritize(tasks)

    tasks_with_time = {}
    time_left_today = max_hours_per_day

    prioritized_tasks.each do |task|
      raw_time = time_for_task(task)

      if raw_time > time_left_today
        raw_time = time_left_today
      end

      rounded_time = raw_time.round_to_quarter

      tasks_with_time[task] = rounded_time
      time_left_today      -= rounded_time

      break if time_left_today <= 0
    end

    tasks_with_time
  end

# IMPLEMENTATION

  def prioritize(tasks)
    tasks.sort do |task|
      task.priority
    end.reverse
  end

  def time_for_task(task)
    if task.estimated_hours_left < min_hours_per_task
      min_hours_per_task
    elsif task.estimated_hours_left >= max_hours_per_task
      max_hours_per_task
    else
      task.estimated_hours_left
    end
  end

  def round_time_to_quarter_hour(time)
    (time * 4).round / 4.0
  end

end
