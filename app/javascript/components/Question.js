import React, { useState, useEffect } from "react";
import styles from "./Question.module.scss";

const Question = ({ question, options }) => {
  const questionWords = question.split(" ");
  const blankIndex = questionWords.indexOf("___");
  const [formattedQuestion, setFormattedQuestion] = useState(question);
  const [hoveredOption, setHoveredOption] = useState();

  useEffect(() => {
    const valueForBlank = hoveredOption || "_____";
    questionWords.splice(blankIndex, 1, valueForBlank);

    setFormattedQuestion(questionWords.join(" "));
  }, [hoveredOption]);

  return (
    <div className={styles.container}>
      <div className={styles.contents}>
        <div className={styles.question}>{formattedQuestion}</div>
        <ol className={styles.options}>
          {options.map(option => (
            <li
              key={option}
              className={styles.option}
              onMouseOver={({ target }) => setHoveredOption(target.innerText)}
              onMouseOut={() => setHoveredOption("_____")}
            >
              <button>{option}</button>
            </li>
          ))}
        </ol>
      </div>
    </div>
  );
};

export default Question;
