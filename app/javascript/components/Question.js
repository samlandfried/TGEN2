import React, { useState, useEffect } from "react";
import { CSSTransitionGroup } from "react-transition-group";
import styles from "./Question.module.scss";

const _normalizeOptions = options => {
  const lengthOfLongestOption = options.reduce(
    (longest, current) => (current.length > longest ? current.length : longest),
    0
  );

  return options.map(option => {
    while (option.length < lengthOfLongestOption) {
      option = `${option} `;
    }

    return option;
  });
};

const Question = ({ question, options }) => {
  const questionWords = question.split(" ");
  const blankIndex = questionWords.indexOf("___");
  const normalizedOptions = _normalizeOptions(options);
  const BLANK = Array(normalizedOptions[0].length)
    .fill("_")
    .join("");
  const [formattedQuestion, setFormattedQuestion] = useState();
  const [hoveredOption, setHoveredOption] = useState(BLANK);

  useEffect(() => {
    const firstWordGroup = questionWords.slice(0, blankIndex);
    const valueForBlank = hoveredOption || BLANK;
    const secondWordGroup = questionWords.slice(blankIndex + 1);

    setFormattedQuestion(
      [firstWordGroup, valueForBlank, secondWordGroup].flat().join(" ")
    );
  }, [hoveredOption]);

  return (
    <div className={styles.container}>
      <div className={styles.contents}>
        <CSSTransitionGroup
          transitionName="example"
          transitionAppear={false}
          transitionEnterTimeout={500}
          transitionLeaveTimeout={500}
        >
          <p key={formattedQuestion} className={styles.question}>
            {formattedQuestion}
          </p>
        </CSSTransitionGroup>
        <ol className={styles.options}>
          {options.map((option, optionI) => (
            <li
              key={option}
              className={styles.option}
              onMouseOver={({ target }) => {
                const index = Number(target.dataset.id);
                setHoveredOption(normalizedOptions[index]);
              }}
              onMouseOut={() => setHoveredOption(BLANK)}
            >
              <button data-id={optionI}>{option}</button>
            </li>
          ))}
        </ol>
      </div>
    </div>
  );
};

export default Question;
