#include "NonogramModel.h"

NonogramModel::NonogramModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

NonogramModel::~NonogramModel()
{
}

int NonogramModel::rowCount(const QModelIndex &parent) const
{
    return m_cells.size();
}

QVariant NonogramModel::data(const QModelIndex &index, int role) const
{
    if (role == IsColored) {
        return m_cells[index.row()];
    }
    return QVariant();
}

QHash<int, QByteArray> NonogramModel::roleNames() const
{
    QHash<int, QByteArray> ret;
    ret[IsColored] = "isColored";
    return ret;
}

QString NonogramModel::title() const
{
    return m_title;
}

void NonogramModel::setTitle(const QString &title)
{
    if (m_title != title) {
        m_title = title;
        emit titleChanged();
    }
}

QString NonogramModel::comment() const
{
    return m_comment;
}

void NonogramModel::setComment(const QString &comment)
{
    if (m_comment != comment) {
        m_comment = comment;
        emit commentChanged();
    }
}

void NonogramModel::init(const QString &title, int cellsAmount, const QString &comment)
{
    m_title = title;
    m_comment = comment;

    // 1 - painted cell; 0 - not painted cell
    for (unsigned i = 0; i < cellsAmount; ++i) {
        m_cells.push_back(0);
    }
    emit layoutChanged();
}

void NonogramModel::toggleCell(int index)
{
    int value = m_cells[index];
    m_cells[index] = (value == 0) ? 1 : 0;
    emit layoutChanged();
}
