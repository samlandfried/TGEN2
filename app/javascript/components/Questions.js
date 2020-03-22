import React, { useEffect, useState } from "react";
import Question from "./Question";
import styles from "./Questions.module.scss";

const Questions = ({ questions }) => {
  const [questionI, setQuestionI] = useState(0);
  const [question, setQuestion] = useState(questions[questionI]);

  useEffect(() => {
    setQuestion(questions[questionI]);
  }, [questionI]);

  return (
    <div className={styles.container}>
      {questions.length > questionI ? (
        <Question
          {...question}
          loadNextQuestion={() => setQuestionI(questionI + 1)}
        />
      ) : (
        "Come back later for more questions."
      )}
    </div>
  );
};

export default Questions;
