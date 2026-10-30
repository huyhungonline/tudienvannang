"""Regression checks for answer-label mapping and option separation."""
import unittest
from pathlib import Path

from normalize_quiz_json import convert_question, split_options


class QuizNormalizationTests(unittest.TestCase):
    def test_keeps_official_answer_when_vietnamese_uses_aiue(self):
        original = dict(question_no=1, knowledge_group="企業と法務", answer="エ",
            question_ja="問1 内容はどれか。\nア 一\nイ 二\nウ 三\nエ 四",
            question_vi="Câu 1: Chọn gì?\nA. Một\nI. Hai\nU. Ba\nE. Bốn",
            explanation_vi="Đáp án E đúng; I sai và U sai.", answer_source="answer_key")
        question, direct = convert_question(original, "2016h28a", Path("exam.pdf"), [2], None)
        self.assertTrue(direct)
        self.assertEqual(question["correct_option_id"], "D")
        self.assertEqual(question["options"][1], dict(id="B", label="イ", ja="二", vi="Hai"))
        self.assertEqual(question["question"]["vi"], "Chọn gì?")
        self.assertEqual(question["explanation_vi"], "Đáp án D đúng; B sai và C sai.")

    def test_keeps_abcd_references(self):
        stem, options, labels = split_options("Chọn?\nA. Một\nB. Hai\nC. Ba\nD. Bốn", "vi")
        self.assertEqual(labels, "ABCD")
        self.assertEqual(options, ["Một", "Hai", "Ba", "Bốn"])

    def test_ambiguous_or_reordered_ocr_requires_model(self):
        self.assertIsNone(split_options("問1 どれか。\nイ 二 ウ 三 エ 四 ア 一", "ja"))
        self.assertIsNone(split_options("問1 どれか。\nア 一\nウ 三\nエ 四", "ja"))


if __name__ == "__main__":
    unittest.main()
