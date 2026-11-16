module TimetablesHelper

  def slot_start(slot)
    (slot.start_at - @timeline.begin) / (@timeline.end - @timeline.begin) * 100
  end

  def slot_width(slot)
    (slot.end_at - slot.start_at) / (@timeline.end - @timeline.begin) * 100
  end

end
