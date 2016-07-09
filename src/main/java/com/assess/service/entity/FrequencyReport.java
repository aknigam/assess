package com.assess.service.entity;

import java.util.List;

public class FrequencyReport
{



	private AppUser m_user;
	
	private List<MultipleChoiceFrequency> m_choiceFrequencies;
	
	

	public AppUser getUser()
	{
		return m_user;
	}


	public void setUser(AppUser user)
	{
		m_user = user;
	}


	public List<MultipleChoiceFrequency> getChoiceFrequencies()
	{
		return m_choiceFrequencies;
	}


	public void setChoiceFrequencies(List<MultipleChoiceFrequency> choiceFrequencies)
	{
		m_choiceFrequencies = choiceFrequencies;
	}
	
	public static class MultipleChoiceFrequency
	{
		public MultipleChoiceFrequency(int multipleChoiceId, String answer, int qId,
				String question, int frequency)
		{
			
			m_question = new Question(qId, question);
			m_frequency = frequency;
			m_choice =  new MultipleChoice(multipleChoiceId,  answer);
			
		}
		public Question getQuestion()
		{
			return m_question;
		}
		public void setQuestion(Question question)
		{
			m_question = question;
		}
		public MultipleChoice getChoice()
		{
			return m_choice;
		}
		public void setChoice(MultipleChoice choice)
		{
			m_choice = choice;
		}
		public Integer getFrequency()
		{
			return m_frequency;
		}
		public void setFrequency(Integer frequency)
		{
			m_frequency = frequency;
		}
		private Question m_question;
		private MultipleChoice m_choice;
		private Integer m_frequency = 0;
	}
}
