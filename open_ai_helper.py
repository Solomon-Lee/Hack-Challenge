import openai
import json
import os

openai.api_key = os.environ.get('OPENAI_API_KEY', None)

def generate_ai_response(prompt):
    response = openai.Completion.create(
        engine='gpt-3.5-turbo',
        prompt=prompt,
        max_tokens=150,
        n=1,
        stop=None,
        temperature=0.5,
    )
    return response.choices[0].text.strip()
